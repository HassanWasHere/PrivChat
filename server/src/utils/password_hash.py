import bcrypt

def hash_password(password):
    salt = bcrypt.gensalt()
    password = str(password).encode("utf-8")
    return bcrypt.hashpw(password, salt).decode("utf-8")

def verify_password(password, hashed):
    return bcrypt.checkpw(password, hashed)


