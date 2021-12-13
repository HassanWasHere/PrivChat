import 'user.dart';

/*
    This class represents a message object. 
    The message object requires the message's id in the messages db table,
    the content of the message and the sender and recipient of the message.
*/
class Message {
    num _message_id;
    String _content;
    User _sender;
    User _recipient;
    double _time_sent;

    Message(this._message_id, this._content, this._sender, this._recipient, this._time_sent);

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
    String get_time_sent(){
        return this._time_sent.toString();
    }
}