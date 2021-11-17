import 'user.dart';
class Message {
    num message_id;
    String content;
    User sender;
    User recipient;

    Message(this.message_id, this.content, this.sender, this.recipient);
}