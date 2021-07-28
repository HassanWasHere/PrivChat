import sqlite3
import os
from src.config.handler import *

class Database:
    def __init__(self, loc):
        self.connection = sqlite3.connect(Config.get_value("PRIVCHAT_ROOT_DIR") + "/db/" + loc)
        self.handle = self.connection.cursor()
    
    def __del__(self):
        self.connection.close()

    def execute(self, command, args=None):
        Result = None
        try:
            Result = self.handle.execute(command, args)
            self.connection.commit()
        except sqlite3.Error as err:
            print(f"SQL ERROR: {err}")
        return Result
    def execute_script(self, script):
        Result = None
        try:
            Result = self.handle.executescript(script)
            self.connection.commit()
        except sqlite3.Error as err:
            print(f"SQL SCRIPT ERROR: {err}")
        return Result
