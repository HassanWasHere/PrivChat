#!/bin/python3
from src.config.handler import *
import os 
Config.set_value("PRIVCHAT_ROOT_DIR",os.path.dirname(os.path.abspath(__file__)))
# Set the directory of the project, this is so the program knows where to find the
# database file

from src import *
from src.routes import start

# Import the server class

app = start.Server()
app.setup_routes()
app.setup_websockets()
app.start()
# Start the server