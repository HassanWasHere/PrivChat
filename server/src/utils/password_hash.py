import bcrypt
from src.database import dbhandler

def hash_password(password):
    salt = bcrypt.gensalt()
    password = str(password).encode("utf-8")
    return bcrypt.hashpw(password, salt).decode("utf-8")

def verify_password(password, hashed):
    return bcrypt.checkpw(password, hashed)

def verify_user(user, given_password):
    if user:
        return verify_password(given_password.encode("utf-8"), user.get_password().encode("utf-8"))
    else:
        return False

