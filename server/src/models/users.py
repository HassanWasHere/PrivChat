from src.database import dbhandler

class User:
    db = dbhandler.Database("privchat.db")
    @classmethod
    def create_from_key(key):
        user = db.execute("SELECT * FROM users WHERE current_key=?", [key]).fetchone()
        
    def __init__(self, user_id, username, password, key, last_seen, avatar):
        self.user_id = user_id
        self.username = username
        self.password = password
        self.key = key
        self.last_seen = last_seen
        self.avatar = avatar

