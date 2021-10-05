from flask import request
from src.utils import validate_input, password_hash
import time
from src.database import dbhandler

recent_addr = dict() # TODO: src.utils.hashtable

def create_route(app):
    @app.route("/signup", methods=["POST"])
    def signup():
        last_try = (request.remote_addr in recent_addr and recent_addr[request.remote_addr]) or 0
        print(last_try)
        if last_try + 5000 < time.time():
            recent_addr[request.remote_addr] = time.time()
            request_data = request.get_json()
            username = validate_input.username(request_data["username"])
            password = validate_input.password(request_data["password"])
            if username and password: 
                password = password_hash.hash_password(password)
                db = dbhandler.Database("privchat.db")
                users_with_name = db.execute("SELECT * FROM users WHERE username=?", [username]).fetchall()
                if len(users_with_name) == 0:
                    print("HELLO?")
                    db.execute("INSERT INTO users (username, password, last_seen) VALUES (?, ?, ?)", [username, password, 0])
                    return "Sucessfully created user!", 200
                else:
                    return "User with name already exists", 403
            else:
                return "No username and password given to server", 405
        else:
            return "Please do not spam user accounts", 406
            

