# This is the password hashing file.
# This file is responsible for taking a password and performing a hashing
# algorithm on it so it can be securely stored in the database.
# This file will also perform the verification of the password by hashing
# the inputted password and comparing it to the already hashed password
import bcrypt
from src.database import dbhandler

def hash_password(password): # Function that hashes the string parameter, this will always be 'password'
    salt = bcrypt.gensalt() # Optional hash parameter used to ensure hashes remain unique
    password = str(password).encode("utf-8") # Convert password to bytes
    return bcrypt.hashpw(password, salt).decode("utf-8") # Hash the password then return it.. but as a string now

def verify_password(password, hashed): # Function returns a boolean
    return bcrypt.checkpw(password, hashed) # Returns true if the password hashed
    # is the same as the one that is already hashed and stored

def verify_user(user, given_password): # Function returns if a user's password is equal to the given_password parameter
    if user: # Make sure user exists
        return verify_password(given_password.encode("utf-8"), user.get_password().encode("utf-8"))
    else:
        return False
# verify_user is a wrapper around verify_password but allows us to just specify a user instead of password
