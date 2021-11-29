from src.utils import validate_input, password_hash
from src.models import users
from flask import request
from flask_socketio import SocketIO, emit, join_room
import json

authenticated_sockets = dict()

def get_user_from_sid(s_id):
    for username in authenticated_sockets:
        if s_id == authenticated_sockets[username]:
            return users.User.create_from_username(username)

def create_socket_routes(socketio):
    @socketio.on("auth")
    def auth(username, password):
        user = users.User.create_from_username(username)
        if password_hash.verify_user(user, password):
            authenticated_sockets[username] = request.sid
            socketio.emit("conversation", json.dumps(user.get_conversations()), to=request.sid)
                
    @socketio.on('conversations')
    def return_conversations():
        user = get_user_from_sid(request.sid)
        if user:
            socketio.emit("conversation", json.dumps(user.get_conversations()), to=request.sid)

    @socketio.on("message")
    def send_message(recipient_id, content):
        print(f"RECIEVED MESSAGE {recipient_id} {content}")
        user = get_user_from_sid(request.sid)
        if user:
            recipient = users.User.create_from_id(recipient_id)
            if recipient:
                #try:
                user.send_message(recipient.user_id, content)
                recipient_room = None
                for username in authenticated_sockets:
                    if username == recipient.username:
                        recipient_room = authenticated_sockets[username]
                if recipient_room:
                    socketio.emit("message", [user.user_id, content], to=recipient_room)
                #except:
                #    print("no")