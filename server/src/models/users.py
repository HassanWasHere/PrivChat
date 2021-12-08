from src.database import dbhandler
from time import time
from src.models.messages import Message
from src.utils.sort import merge_sort

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
        self.__user_id = user_id
        self.__username = username
        self.__password = password
        self.__last_seen = last_seen
        self.__avatar = avatar
        self.__valid_session = False
        self.__db = dbhandler.Database("privchat.db")
    def get_user_id(self):
        return self.__user_id
    def get_username(self):
        return self.__username
    def get_password(self):
        return self.__password
    def get_messages(self):
        messages = self.__db.execute("SELECT * from messages WHERE sender_id=? OR recipient_id=?", [self.__user_id, self.__user_id]).fetchall()
        messages_comp = []
        for message in messages:
            messages_comp.append(Message(message[0], message[1], message[2], message[3], message[4]))
        for i in range(len(messages_comp)):
            for j in range(len(messages_comp)-1):
                if messages_comp[j].get_time_sent() > messages_comp[j+1].get_time_sent():
                    messages_comp[j], messages_comp[j+1] = messages_comp[j+1], messages_comp[j]
        return merge_sort(messages_comp)
    def get_conversations(self):
        conversations = dict()
        if self.get_messages():
            for msg in self.get_messages():
                if msg.get_sender_id() == self.__user_id:
                    other_user_id = msg.get_recipient_id()
                else:
                    other_user_id = msg.get_sender_id()
                message_data = dict()
                message_data["sender_id"] = msg.get_sender_id()
                message_data["recipient_id"] = msg.get_recipient_id()
                message_data["content"] = msg.get_content()
                message_data["time_sent"] = msg.get_time_sent()
                message_data["message_id"] = msg.get_message_id()
                if not int(other_user_id) in conversations:
                    conversations[int(other_user_id)] = [message_data]
                else:
                    conversations[int(other_user_id)].append(message_data)
        return conversations
    def send_message(self, recipient_id, content):
        self.__db.execute("INSERT INTO messages (content, time_sent, sender_id, recipient_id) VALUES (?,?,?,?)", [content, time(), self.__user_id, recipient_id])
        return self.__db.get_last_row_id()
