import '../api/network.dart';
import 'messages.dart';
import 'package:flutter/material.dart';
class Conversation {
    num sender_id;
    var messages;

    Conversation(this.sender_id, this.messages);

    factory Conversation.FromJSON(Map<String, dynamic> json) {
        debugPrint("YEP!");
        json.forEach((i,v) => debugPrint(v[0]));
        return Conversation(1, null);
    }
}