//import '../api/network.dart';
import 'messages.dart';
import 'user.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
class Conversation {
    User other_user = User(-1);
    var messages = <Message>[];

    void addMessage(message, User sender, User recipient){
        messages.add(Message(message['message_id'], message['content'], sender, recipient));
    }

    Conversation(User other_user){
        this.other_user = other_user;
    }

    List<Message> getMessages(){
        print(this.messages.length);
        return this.messages;
    }
}