import flask
from flask_socketio import SocketIO, emit
from src.routes import signup, messages, user, sockets

app = flask.Flask(__name__)
app.debug = True

signup.create_route(app)
messages.create_route(app)
user.create_route(app)

socketio = SocketIO(app, cors_allowed_origins="*")

sockets.create_socket_routes(socketio)

def start_listening():
    socketio.run(app, host="localhost", port=8080)
