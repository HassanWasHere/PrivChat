from src.database import dbhandler

class Message:
    def __init__(self, message_id, content, time_sent, sender_id, recipient_id):
        self.__message_id = message_id
        self.__content = content
        self.__time_sent = time_sent
        self.__sender_id = sender_id
        self.__recipient_id = recipient_id
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

    def __eq__(self, other):
        return self.__time_sent == other.get_time_sent()
    def __lt__(self, other):
        return self.__time_sent < other.get_time_sent()
    def __gt__(self, other):
        return self.__time_sent > other.get_time_sent()
