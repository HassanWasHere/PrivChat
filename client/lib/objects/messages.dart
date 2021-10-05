import 'user.dart';
class Message {
    num message_id = 0;
    String content = "";
    User sender;
    User recipient;

    Message(this.message_id, this.content, this.sender, this.recipient);

    factory Message.FromJSON(Map<String, dynamic> json) {
        return Message(json['message_id'], json['content'], User("a",1), User("b",2));
    }
}