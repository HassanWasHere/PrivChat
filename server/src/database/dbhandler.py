import sqlite3
import os
from src.config.handler import *
# This class represents a database connection.
# It is responsible for initiating a database connection
# then providing a safe wrapper for querying the database
class Database:
    # Constructor creates sqlite connection to the database.
    def __init__(self, loc):
        self.__connection = sqlite3.connect(Config.get_value("PRIVCHAT_ROOT_DIR") + "/db/" + loc)
        self.__handle = self.__connection.cursor()
    
    def __del__(self):
        self.__connection.close()
    # Function executes basic one line SQL queries then returns the result
    def execute(self, command, args=None):
        Result = None
        try:
            Result = self.__handle.execute(command, args)
            self.__connection.commit()
        except sqlite3.Error as err:
            print(f"SQL ERROR: {err}")
        return Result
    # This function is capable of executing an entire SQL script and returning the result.
    # This is useful for executing my DDL script at the start of the program.
    def execute_script(self, script):
        Result = None
        try:
            Result = self.__handle.executescript(script)
            self.__connection.commit()
        except sqlite3.Error as err:
            print(f"SQL SCRIPT ERROR: {err}")
        return Result
    # This returns the primary key of the last inserted element.
    # This is useful as the primary key is auto incremented and not inserted by me, so unknown before insert.
    def get_last_row_id(self):
        return self.__handle.lastrowid
