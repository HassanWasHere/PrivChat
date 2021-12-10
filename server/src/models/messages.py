from src.database import dbhandler
# Class represents each message sent on the server
class Message:
    # Class constructor.
    def __init__(self, message_id, content, time_sent, sender_id, recipient_id):
        self.__message_id = message_id
        self.__content = content
        self.__time_sent = time_sent
        self.__sender_id = sender_id
        self.__recipient_id = recipient_id
    # Getters used to fetch message information
    def get_message_id(self):
        return self.__message_id
    def get_content(self):
        return self.__content
    def get_time_sent(self):
        return self.__time_sent
    def get_sender_id(self):
        return self.__sender_id
    def get_recipient_id(self):
        return self.__recipient_id
    # When comparing this class using arithmetic operators, we want to compare the time_sent of the message.
    # This just makes it easier to sort, for example when using a merge sort.
    def __eq__(self, other):
        return self.__time_sent == other.get_time_sent()
    def __lt__(self, other):
        return self.__time_sent < other.get_time_sent()
    def __gt__(self, other):
        return self.__time_sent > other.get_time_sent()
