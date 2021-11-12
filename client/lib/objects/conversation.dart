//import '../api/network.dart';
import 'messages.dart';
import 'user.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
class Conversation {
    User other_user = User(-1, "ERROR");
    var messages = <Message>[];

    void addMessage(num message_id, String content, User sender, User recipient){
        print("ADDING MESSAGES");
        messages.add(Message(message_id, content, sender, recipient));
    }

    Conversation(User other_user){
        this.other_user = other_user;
    }

    List<Message> getMessages(){
        print(this.messages.length);
        return this.messages;
    }
}