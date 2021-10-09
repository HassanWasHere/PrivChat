import 'package:flutter/material.dart';
import '../objects/conversation.dart';
import 'dart:convert';
class MessageListPage extends StatefulWidget {
    MessageListPage({Key? key}) : super(key: key);

    String Response = '';

    void setResponseData(String data){
        Response = data;
    }

    @override
    _MessageListPageWithState createState() =>  _MessageListPageWithState();
}


class _MessageListPageWithState extends State<MessageListPage> {
    var Conversations = <Conversation>[];
    void loadConversations(){
        var conversationsJSON = jsonDecode(widget.Response); // Map<sender_id, <Conversation>>
        conversationsJSON.forEach((sender_id, message_list){
            Conversations.add(
                Conversation(int.parse(sender_id), message_list)
            );
        });
    }
    Widget build(BuildContext ctx){
        loadConversations();
        return Scaffold(
            body: Text(widget.Response)
        );
    }
}