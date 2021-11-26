from src.utils import validate_input, password_hash
from src.models import users
import json

def create_socket_routes(socketio):
    @socketio.on('conversations')
    def return_conversations(username, password):
        user = users.User.create_from_username(username)
        if password_hash.verify_user(user, password):
            socketio.emit("conversation", json.dumps(user.get_conversations()))