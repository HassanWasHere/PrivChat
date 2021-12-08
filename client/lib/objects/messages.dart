import 'user.dart';
class Message {
    num _message_id;
    String _content;
    User _sender;
    User _recipient;

    Message(this._message_id, this._content, this._sender, this._recipient);

    num get_message_id(){
        return this._message_id;
    }
    String get_content(){
        return this._content;
    }
    User get_sender(){
        return this._sender;
    }
    User get_recipient(){
        return this._recipient;
    }
}