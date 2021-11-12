import flask
from flask_cors import CORS
from src.routes import signup, messages, user

app = flask.Flask(__name__)
app.debug = True
CORS(app)
signup.create_route(app)
messages.create_route(app)
user.create_route(app)

def start_listening():
    app.run(host="localhost", port=8080)
