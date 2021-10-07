#!/bin/python3
from src.config.handler import *
import os 
Config.set_value("PRIVCHAT_ROOT_DIR",os.path.dirname(os.path.abspath(__file__)))

if  Config.get_value("PRIVCHAT_SECRET_KEY"):
    print("Unable to start server, no secret key set..")
else:
    from src import *
    from src.routes import start
    import src.models
    start.start_listening()

