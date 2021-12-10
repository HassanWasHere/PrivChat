from src.utils import validate_input, password_hash
from src.models import users
from flask import request
from flask_socketio import SocketIO, emit, join_room
import json

# This creates the WebSocketServer class for the Server class to initiate and use
# This will be responsible for listening to the web socket for data
# then processing it and responding accordingly. The class has two private attributes, __socketio which is the 
# socket handler and __authenticated_sockets which is a dictionary that holds all the currently connected
# WebSockets which has been authenticated


class WebSocketServer:
    def __init__(self, socketio):
        self.__authenticated_sockets = dict()
        self.__socketio = socketio

    # Simple algorithm for iterating through the dictionary and returning the user from the
    # given socket
    def get_user_from_sid(self, s_id):
        for username in self.__authenticated_sockets:
            if s_id == self.__authenticated_sockets[username]:
                return users.User.create_from_username(username)
    
    # This procedure sets up the WebSocket listeners
    def create_socket_routes(self):
        # This is setting up the authentication listener, listening for 'auth' message
        # if it recieves 'auth' it will perform the following procedure
        # It will fetch the user from the unique username, create the user instance,
        # verify the password then add them into __authenticated_sockets if correct
        @self.__socketio.on("auth")
        def auth(username, password):
            user = users.User.create_from_username(username)
            if password_hash.verify_user(user, password):
                self.__authenticated_sockets[username] = request.sid
                self.__socketio.emit("conversation", json.dumps(user.get_conversations()), to=request.sid)
        
        # Sets up the conversations listener, listening for 'conversations' across WebSocket
        # It will check if the user is authenticated, if they are
        # it will return all their conversations
        @self.__socketio.on('conversations')
        def return_conversations():
            user = self.get_user_from_sid(request.sid)
            if user:
                self.__socketio.emit("conversation", json.dumps(user.get_conversations()), to=request.sid)

        # This is the messages listener, it listens for 'message' across the WebSocket
        # If the user is authenticated, the message recipient and content is taken
        # and sent to the appropriate user by inserting it into the database
        # then sending it across the appropriate WebSocket.
        @self.__socketio.on("message")
        def send_message(recipient_id, content):
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