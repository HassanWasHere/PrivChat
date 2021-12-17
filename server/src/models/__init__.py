from src.database import dbhandler
import os
import glob

db = dbhandler.Database("privchat.db")
for f in glob.glob("**/*.ddl", recursive=True): # Scan directory for files ending in .ddl
    f = open(f, "r") # Open it in read mode
    db.execute_script(f.read()) # Execute the DDL script
