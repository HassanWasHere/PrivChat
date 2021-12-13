from src.database import dbhandler
from time import time
from src.models.messages import Message
from src.utils.sort import merge_sort
# This is the User class. User information is fetched from the database 
# then used to create this User object. This is to allow easy access of user
# information across the program.
class User:
    # This is a class method, so it will create the User class by fetching
    # information about the user in the database using their username.
    @classmethod
    def create_from_username(cls, username):
        db = dbhandler.Database("privchat.db")
        user = db.execute("SELECT * FROM users WHERE username=?", [username]).fetchone()
        if user:
            return cls(user[0], user[1], user[2], user[3], user[4])
        else:
            return False
    # This is a class method, so it will create the User class by fetching
    # information about the user in the database using their user_id.
    @classmethod
    def create_from_id(cls, user_id):
        db = dbhandler.Database("privchat.db")
        user = db.execute("SELECT * FROM users WHERE user_id=?", [user_id]).fetchone()
        if user:
            return cls(user[0], user[1], user[2], user[3], user[4])
        else:
            return False
    # This is the class constructor. All their information is stored over here.
    def __init__(self, user_id, username, password, time_created, avatar):
        self.__user_id = user_id
        self.__username = username
        self.__password = password
        self.__time_created = time_created
        self.__avatar = avatar
        self.__valid_session = False
        self.__db = dbhandler.Database("privchat.db")
    # Getters/Setters to provide encapsulation
    # Get and set the user informaion as needed
    def get_user_id(self):
        return self.__user_id
    def get_username(self):
        return self.__username
    def get_password(self):
        return self.__password
    # Gets the user's messages from the messages table of the database then return it after merge sorting it.
    def get_messages(self):
        messages = self.__db.execute("SELECT * from messages WHERE sender_id=? OR recipient_id=?", [self.__user_id, self.__user_id]).fetchall()
        messages_comp = []
        for message in messages:
            messages_comp.append(Message(message[0], message[1], message[2], message[3], message[4]))
        return merge_sort(messages_comp)
    # Takes the user's ordered messages and creates a dictionary of conversations.
    # The dictionary key is the other user in the conversation, (not the user represented by this class)
    # The dictionary value is another dictionary called 'message_data'.
    # This is essentially breaing down the message object into a dictionary so it can be
    # easily JSON encoded and returned to the server.
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
    # This function simply adds a new message into the database. The WebSocket server will
    # forward it to the correct WebSocket aswell.
    def send_message(self, recipient_id, content):
        self.__db.execute("INSERT INTO messages (content, time_sent, sender_id, recipient_id) VALUES (?,?,?,?)", [content, round(time() * 1000), self.__user_id, recipient_id])
        return self.__db.get_last_row_id()
