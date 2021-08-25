from flask import request
from src.utils import validate_input, password_hash
import time
from src.database import dbhandler

recent_addr = dict() # TODO: src.utils.hashtable

def create_route(app):
    @app.route("/signup", methods=["POST"])
    def signup():
        last_try = (request.remote_addr in recent_addr and recent_addr[request.remote_addr]) or 0
        if last_try < time.time():
            recent_addr[request.remote_addr] = time.time()
            username = validate_input.username(request.form["username"])
            password = validate_input.password(request.form["password"])
            if username and password: 
                password = password_hash.hash_password(password)
                db = dbhandler.Database("privchat.db")
                users_with_name = db.execute("SELECT * FROM users WHERE username=?", [username]).fetchall()
                if len(users_with_name) == 0:
                    db.execute("INSERT INTO users (username, password, last_seen) VALUES (?, ?, ?)", [username, password, 0])
                    return "attempted to insert"
                else:
                    return "user with name already exists"
            else:
                return "no user and pass"
        else:
            return "ratelimit"
            

