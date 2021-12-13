//import '../api/network.dart';
import 'messages.dart';
import 'user.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
class Conversation {
    User _other_user;
    List<Message> _messages = <Message>[];

    void add_message(num message_id, String content, User sender, User recipient, double time_sent){
        this._messages.add(Message(message_id, content, sender, recipient, time_sent));
    }

    Conversation(@required this._other_user);

    List<Message> get_messages(){
        return this._messages;
    }

    User get_other_user(){
        return this._other_user;
    }
}