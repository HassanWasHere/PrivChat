import flask
from flask_socketio import SocketIO
from src.routes import signup, messages, user, sockets

class Server(flask.Flask):
    def __init__(self):
        super().__init__(__name__)
        self.debug = True
        self.__socketio = None
    def setup_routes(self):
        signup.create_route(self)
        messages.create_route(self)
        user.create_route(self)
    def setup_websockets(self):
        self.__socketio = SocketIO(self, cors_allowed_origins="*")
        wss_server = sockets.WebSocketServer(self.__socketio)
        wss_server.create_socket_routes()
    def start(self):
        self.__socketio.run(app, host="localhost", port=8080)

app = Server()
app.setup_routes()
app.setup_websockets()
app.start()