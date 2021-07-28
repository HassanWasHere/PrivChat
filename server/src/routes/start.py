import flask
from flask_socketio import SocketIO
from src.routes import signup

app = flask.Flask(__name__)

signup.create_route(app)
socketio = SocketIO(app, cors_allowed_origins="*")

@socketio.on("connect")
def connected():
    print("CONNECTED")

def start_listening():
    socketio.run(app)
    #app.run(host="0.0.0.0", port=8080)
