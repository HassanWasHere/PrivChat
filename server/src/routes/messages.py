from flask import request
from src.utils import validate_input, password_hash
import json
from src.database import dbhandler

def create_route(app):
    @app.route("/messages", methods=["GET"])
    def messages():
        
            

