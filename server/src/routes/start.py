import flask
from src.routes import signup, messages

app = flask.Flask(__name__)

signup.create_route(app)
messages.create_route(app)

def connected():
    print("CONNECTED")

def start_listening():
    app.run(host="0.0.0.0", port=8080)
