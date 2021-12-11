from flask import request
from src.utils import validate_input, password_hash
import time
from src.database import dbhandler

recent_addr = dict() # Create a dictionary with recently connected addresses 

def create_route(app): # This procedure is called by the server to start listening at the /signup.
    @app.route("/signup", methods=["POST"]) # Listen for only POST requests at /signup
    def signup():
        last_try = (request.remote_addr in recent_addr and recent_addr[request.remote_addr]) or 0 # Check hashtable for
        # last time this IP tried to use the API. 0 if not before.
        if last_try + 5 < time.time(): # Selection that checks if it's been a certain amount of time since last request
            recent_addr[request.remote_addr] = time.time() # If it has add new tiem into dictionary
            request_data = request.get_json() # Get JSON imported request
            if request_data:
                username = validate_input.valid_username(request_data["username"]) # Make sure username, password and public key are correct
                password = validate_input.valid_password(request_data["password"])
                pub_key = request_data["pubkey"]#validate_input.valid_pubkey(request_data["pubkey"])
                if username and password and pub_key: # If the validation is successful
                    password = password_hash.hash_password(password) # Perform a cryptographic hash on the password to store it
                    db = dbhandler.Database("privchat.db") # Establish connection to database
                    users_with_name = db.execute("SELECT * FROM users WHERE username=?", [username]).fetchall() 
                    if len(users_with_name) == 0: # Check if user with given username doesn't already exist
                        try:
                            # Try and put in new user information in user table and new key in the key table
                            db.execute("INSERT INTO users (username, password, time_created) VALUES (?, ?, ?)", [username, password, 0])
                            user_id = db.get_last_row_id() # Get auto incremented user_id from inserting into users. This is used for the foreign key in the keys table
                            db.execute("INSERT INTO keys (user_id, pub_key) VALUES (?,?)", [user_id, pub_key])
                        except:
                            return "Database error", 401
                        return "Sucessfully created user!", 200
                    else:
                        return "User with name already exists", 403
                else:
                    return "No username and password given to server", 405
        else:
            return "Please do not spam user accounts", 406
            

