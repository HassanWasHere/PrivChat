//import '../api/network.dart';
import 'messages.dart';
import 'user.dart';
import 'package:flutter/material.dart';
class Conversation {
    User other_user = User(-1);
    var messages = <Message>[];

    Conversation(User other_user, got_messages){
        this.other_user = other_user;
        got_messages.forEach((message){
            print(message.toString());
            User(message.sender_id).createUserFromID().then((sender){
                User(message.recipient_id).createUserFromID().then((recipient){
                    messages.add(Message(message['message_id'], message['content'], sender, recipient));
                });
            });
            
        });
    }
}