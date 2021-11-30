//import '../api/network.dart';
import 'messages.dart';
import 'user.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
class Conversation {
    User other_user;
    List<Message> messages = <Message>[];

    void addMessage(num message_id, String content, User sender, User recipient){
        print("ADDING NEW MESSAGE FROM " + sender.user_id.toString() + " TO " + recipient.user_id.toString());
        messages.add(Message(message_id, content, sender, recipient));
    }

    Conversation(@required this.other_user);

    List<Message> getMessages(){
        return this.messages;
    }
}