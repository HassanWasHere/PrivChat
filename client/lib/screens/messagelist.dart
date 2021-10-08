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
    var ConversationsJSON = jsonDecode(widget.Response);
    var Conversations;
    void loadConversations(){
        Conversation.FromJSON();
    }
    Widget build(BuildContext ctx){
        loadConversations();
        return Scaffold(
            body: Text(widget.Response)
        );
    }
}