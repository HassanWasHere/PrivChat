from src.utils import validate_input, password_hash
from src.models import users
import json

def create_socket_routes(socketio):
    @socketio.on('conversations')
    def return_conversations(username, password):
        user = users.User.create_from_username(username)
        if password_hash.verify_user(user, password):
            socketio.emit("conversation", json.dumps(user.get_conversations()))

    @socketio.on("message")
    def send_message(username, password, recipient_id, content):
        user = users.User.create_from_username(username)
        if password_hash.verify_user(user, password):
            recipient = users.User.create_from_id(recipient_id)
            if recipient:
                try:
                    user.send_message(recipient.user_id, content)
                    socketio.emit("conversation", json.dumps(user.get_conversations()))
                except:
                    print("no")