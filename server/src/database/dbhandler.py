import sqlite3
import os
from src.config.handler import *

class Database:
    def __init__(self, loc):
        self.__connection = sqlite3.connect(Config.get_value("PRIVCHAT_ROOT_DIR") + "/db/" + loc)
        self.__handle = self.__connection.cursor()
    
    def __del__(self):
        self.__connection.close()

    def execute(self, command, args=None):
        Result = None
        try:
            Result = self.__handle.execute(command, args)
            self.__connection.commit()
        except sqlite3.Error as err:
            print(f"SQL ERROR: {err}")
        return Result
    def execute_script(self, script):
        Result = None
        try:
            Result = self.__handle.executescript(script)
            self.__connection.commit()
        except sqlite3.Error as err:
            print(f"SQL SCRIPT ERROR: {err}")
        return Result
    def get_last_row_id(self):
        return self.__handle.lastrowid
