//import '../api/network.dart';
import 'messages.dart';
import 'user.dart';
import 'package:flutter/material.dart';
class Conversation {
    User other_user = User("ERROR", -1);
    var messages = <Message>[];

    Conversation(User other_user, got_messages){
        this.other_user = other_user;
        got_messages.forEach((message){
            messages.add(Message(message['message_id'], message['content'], User("a",0), User("b",2)));
        });
    }
}