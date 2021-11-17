from flask import request, abort
from src.utils import validate_input, password_hash
import json
from src.database import dbhandler
from src.models import users

def create_route(app):
    @app.route("/messages", methods=["GET", "POST"])
    def messages():
        db = dbhandler.Database("privchat.db")
        auth = request.authorization
        if auth:
            user = users.User.create_from_username(auth.username)
            if password_hash.verify_user(user, auth.password):
                if request.method == "GET":
                    conversations = dict()
                    if user.get_messages():
                        for msg in user.get_messages():
                            if msg.sender_id == user.user_id:
                                other_user_id = msg.recipient_id
                            else:
                                other_user_id = msg.sender_id
                            if not int(other_user_id) in conversations:
                                conversations[int(other_user_id)] = [msg.__dict__]
                            else:
                                conversations[int(other_user_id)].append(msg.__dict__)
                        return json.dumps(conversations)
                    else:
                        return {}
                elif request.method == "POST":
                    request_data = request.get_json()
                    if request_data:
                        content = request_data["content"]
                        recipient_id = request_data["recipient_id"]
                        recipient = users.User.create_from_id(recipient_id)
                        if recipient:
                            try:
                                user.send_message(recipient.user_id, content)
                                return "success", 200
                            except:
                                return "an error occured", 401
                        else:
                            return "no data sent", 401
                    else:
                        return "no recipient", 401
            else:
                return "incorrect username or password", 403
        else:
            return "please enter credentials", 404

        
            

