from flask import request, abort
from src.utils import validate_input, password_hash
import json
from src.database import dbhandler
from src.models import users

# This is the user HTTP REST API endpoint.
# When the user sends a request to this endpoint with a user_id or username
# The endpoint will retrieve the user's information and their public key from the database
# Encode this in JSON format then return it to the server.
def create_route(app):
    @app.route("/user", methods=["GET", "POST"])
    def user():
        db = dbhandler.Database("privchat.db")
        user_id = request.args.get("id")
        user_name = request.args.get("username")
        if user_id:
            try:
                user_info = db.execute("SELECT users.username, keys.pub_key FROM users,keys WHERE users.user_id=keys.user_id AND users.user_id=?", [user_id]).fetchone()
                return json.dumps(user_info)
            except:
                return "Error fetching user information", 401
        elif user_name:
            try:
                user_info = db.execute("SELECT users.user_id, keys.pub_key FROM users,keys WHERE users.user_id=keys.user_id AND users.username=?", [user_name]).fetchone()
                return json.dumps(user_info)
            except:
                return "Error fetching user information", 401

