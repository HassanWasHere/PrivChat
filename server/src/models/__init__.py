from src.database import dbhandler
import os
import glob

db = dbhandler.Database("privchat.db")
print("HELLO?") 
for f in glob.glob("**/*.sql", recursive=True):
    f = open(f, "r")
    db.execute_script(f.read())
