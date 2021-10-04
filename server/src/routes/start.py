import flask
from src.routes import signup, messages

app = flask.Flask(__name__)
app.debug = True

signup.create_route(app)
messages.create_route(app)

def start_listening():
    app.run(port=8080)
