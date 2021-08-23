from flask import request, abort
from src.utils import validate_input, password_hash
import json
from src.database import dbhandler

def create_route(app):
    @app.route("/messages", methods=["GET"])
    def messages():
        db = dbhandler.Database("privchat.db")
        auth = request.authorization
        if password_hash.verify_user(auth.username, auth.password):
            if request.method == "GET":
                messages = db.execute("SELECT * FROM messages WHERE sender_id=? OR recipient_id=?", [auth.username, auth.username]).fetchall()
                return json.dumps(messages)
        else:
            abort(401)

        
            

