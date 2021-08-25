from src.database import dbhandler
from time import time

class User:
    @classmethod
    def create_from_username(cls, username):
        db = dbhandler.Database("privchat.db")
        user = db.execute("SELECT * FROM users WHERE username=?", [username]).fetchone()
        if user:
            return cls(user[0], user[1], user[2], user[3], user[4])
        else:
            return False
    def __init__(self, user_id, username, password, last_seen, avatar):
        self.user_id = user_id
        self.username = username
        self.password = password
        self.last_seen = last_seen
        self.avatar = avatar
        self.valid_session = False
        self.db = dbhandler.Database("privchat.db")
    def get_messages(self):
        messages = self.db.execute("SELECT * from messages WHERE sender_id=? OR recipient_id=?", [self.user_id, self.user_id]).fetchall()
        return messages #TODO: src.models.messages.Message()

    def send_message(self, recipient_id, content):
        return self.db.execute("INSERT INTO messages (content, time_sent, sender_id, recipient_id) VALUES (?,?,?,?)", [content, time(), self.user_id, recipient_id])