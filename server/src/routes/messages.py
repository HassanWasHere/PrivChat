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
                    print(user.get_messages())
                    if user.get_messages():
                        for msg in user.get_messages():
                            if not int(msg.sender_id) in conversations:
                                conversations[int(msg.sender_id)] = [msg.__dict__]
                            else:
                                conversations[int(msg.sender_id)].append(msg.__dict__)
                        return json.dumps(conversations)
                    else:
                        return {}
                elif request.method == "POST":
                    content = request.form.get("content")
                    recipient_name = request.form.get("recipient")
                    recipient = users.User.create_from_username(recipient_name)
                    if recipient and content:
                        try:
                            user.send_message(recipient.user_id, content)
                            return "success", 200
                        except:
                            return "an error occured", 401
                    else:
                        return "no recipient/content", 401
            else:
                return "incorrect username or password", 404
        else:
            return "please enter credentials", 404

        
            

