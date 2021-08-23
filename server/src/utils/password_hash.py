import bcrypt
from src.database import dbhandler

def hash_password(password):
    salt = bcrypt.gensalt()
    password = str(password).encode("utf-8")
    return bcrypt.hashpw(password, salt).decode("utf-8")

def verify_password(password, hashed):
    return bcrypt.checkpw(password, hashed)

def verify_user(username, given_password):
    db = dbhandler.Database("privchat.db")
    user = db.execute("SELECT * FROM users WHERE username=?", [username]).fetchone() or ""
    return verify_password(given_password.encode("utf-8"), user[2].encode("utf-8"))

