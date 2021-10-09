import '../api/network.dart';
import 'messages.dart';
import 'user.dart';
import 'package:flutter/material.dart';
class Conversation {
    num sender_id = 0;
    var messages = <Message>[];

    Conversation(num sender_id, got_messages){
        this.sender_id = sender_id;
        got_messages.forEach((message){
            messages.add(Message(message['message_id'], message['content'], User("a",0), User("b",2)));
        });
    }
}