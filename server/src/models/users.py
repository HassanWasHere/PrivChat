from src.database import dbhandler
from time import time
from src.models.messages import Message

class User:
    @classmethod
    def create_from_username(cls, username):
        db = dbhandler.Database("privchat.db")
        user = db.execute("SELECT * FROM users WHERE username=?", [username]).fetchone()
        if user:
            return cls(user[0], user[1], user[2], user[3], user[4])
        else:
            return False
    @classmethod
    def create_from_id(cls, user_id):
        db = dbhandler.Database("privchat.db")
        user = db.execute("SELECT * FROM users WHERE user_id=?", [user_id]).fetchone()
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
        self.__db = dbhandler.Database("privchat.db")
    def get_messages(self):
        messages = self.__db.execute("SELECT * from messages WHERE sender_id=? OR recipient_id=?", [self.user_id, self.user_id]).fetchall()
        messages_comp = []
        for message in messages:
            messages_comp.append(Message(message[0], message[1], message[2], message[3], message[4]))
        return messages_comp
    def get_conversations(self):
        conversations = dict()
        if self.get_messages():
            for msg in self.get_messages():
                if msg.sender_id == self.user_id:
                    other_user_id = msg.recipient_id
                else:
                    other_user_id = msg.sender_id
                if not int(other_user_id) in conversations:
                    conversations[int(other_user_id)] = [msg.__dict__]
                else:
                    conversations[int(other_user_id)].append(msg.__dict__)
        return conversations
    def send_message(self, recipient_id, content):
        return self.__db.execute("INSERT INTO messages (content, time_sent, sender_id, recipient_id) VALUES (?,?,?,?)", [content, time(), self.user_id, recipient_id])
