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
        setState((){
            var conversationsJSON = jsonDecode(widget.Response); // Map<sender_id, <Conversation>>
            conversationsJSON.forEach((sender_id, message_list){
                Conversations.add(
                    Conversation(int.parse(sender_id), message_list)
                );
            });
        });
    }
    void initState(){
        loadConversations();
    }
    Widget build(BuildContext ctx){
        return Scaffold(
            body: ListView.builder(
                itemCount: Conversations.length,
                itemBuilder: (context, index) {
                    return ListTile(
                        title: Text(Conversations[index].messages[0].content),
                    );
                },
            ),
        );
    }
}