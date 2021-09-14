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
                            print(msg.__dict__)
                            if not msg.recipient_id in conversations:
                                conversations[msg.recipient_id] = [msg.__dict__]
                            else:
                                conversations[msg.recipient_id].append(msg.__dict__)
                        return json.dumps(conversations)
                    else:
                        return "no messages"
                elif request.method == "POST":
                    content = request.form.get("content")
                    recipient_name = request.form.get("recipient")
                    recipient = users.User.create_from_username(recipient_name)
                    if recipient and content:
                        try:
                            user.send_message(recipient.user_id, content)
                            return "success"
                        except:
                            return "an error occured"
                    else:
                        return "no recipient/content"
            else:
                abort(401)
        else:
            abort(401)

        
            

