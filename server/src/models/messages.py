from src.database import dbhandler

class Message:
    def __init__(self, message_id, content, time_sent, sender_id, recipient_id):
        self.message_id = message_id
        self.content = content
        self.time_sent = time_sent
        self.sender_id = sender_id
        self.recipient_id = recipient_id
        
