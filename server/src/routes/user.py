from flask import request, abort
from src.utils import validate_input, password_hash
import json
from src.database import dbhandler
from src.models import users

def create_route(app):
    @app.route("/user", methods=["GET", "POST"])
    def user():
        db = dbhandler.Database("privchat.db")
        user_id = request.args.get("id")
        try:
            user_info = db.execute("SELECT username, avatar_url FROM users WHERE user_id=?", [user_id]).fetchone()
            return json.dumps(user_info)
        except:
            return "Error fetching user information", 401

