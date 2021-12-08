from src.utils import validate_input, password_hash
from src.models import users
from flask import request
from flask_socketio import SocketIO, emit, join_room
import json

class WebSocketServer:
    def __init__(self, socketio):
        self.__authenticated_sockets = dict()
        self.__socketio = socketio

    def get_user_from_sid(self, s_id):
        for username in self.__authenticated_sockets:
            if s_id == self.__authenticated_sockets[username]:
                return users.User.create_from_username(username)

    def create_socket_routes(self):
        @self.__socketio.on("auth")
        def auth(username, password):
            user = users.User.create_from_username(username)
            if password_hash.verify_user(user, password):
                self.__authenticated_sockets[username] = request.sid
                self.__socketio.emit("conversation", json.dumps(user.get_conversations()), to=request.sid)
                    
        @self.__socketio.on('conversations')
        def return_conversations(self):
            user = self.get_user_from_sid(request.sid)
            if user:
                self.__socketio.emit("conversation", json.dumps(user.get_conversations()), to=request.sid)

        @self.__socketio.on("message")
        def send_message(self, recipient_id, content):
            print(f"RECIEVED MESSAGE {recipient_id} {content}")
            user = self.get_user_from_sid(request.sid)
            if user:
                recipient = users.User.create_from_id(recipient_id)
                if recipient:
                    #try:
                    message_id = user.send_message(recipient.get_user_id(), content)
                    recipient_room = None
                    for username in self.__authenticated_sockets:
                        if username == recipient.get_username():
                            recipient_room = self.__authenticated_sockets[username]
                    if recipient_room:
                        self.__socketio.emit("message", [user.get_user_id(), content], to=recipient_room)
                    print("MESSAGE ID IS " + str(message_id))
                    return message_id
                    #except:
                    #    print("no")