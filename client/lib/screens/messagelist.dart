import 'package:flutter/material.dart';
import '../objects/conversation.dart';
import 'dart:convert';
import '../objects/user.dart';
import '../objects/messages.dart';
import '../objects/client.dart';
class MessageListPage extends StatefulWidget {
    MessageListPage({Key? key}) : super(key: key);

    String Response = '';
    Client thisUser;

    void setResponseData(String data){
        Response = data;
    }

    void setClientData(Client client){
        thisUser = client;
    }

    @override
    _MessageListPageWithState createState() =>  _MessageListPageWithState();
}


class _MessageListPageWithState extends State<MessageListPage> {
    var Conversations = <Conversation>[];
    void loadConversations(){
        setState((){
            var conversationsJSON = jsonDecode(widget.Response);
            conversationsJSON.forEach((other_user_id, message_list){
                var otherUser = User(int.parse(other_user_id));
                var newConversation = Conversation(other_user);
                message_list.forEach((message){
                    User sender;
                    User recipient;
                    if (other_user_id == message['sender_id']){
                        sender = otherUser;
                        recipient = widget.thisUser;
                    } else {
                        sender = widget.thisUser;
                        recipient = otherUser;
                    }
                    newConversation.addMessage(message['message_id'], message['content'], sender, recipient);
                })
                Conversations.add(newConversation);
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
                    var conversation = Conversations[index];
                    String messageContent;
                    if (conversation.getMessages().length == 0){
                        messageContent = "No messages sent to this user";
                    } else {
                        messageContent = conversation.getMessages()[0].content;
                    }
                    
                    return ListTile(
                        title: Text(conversation.other_user.username),
                        subtitle: Text(messageContent)
                    );
                },
            ),
        );
    }
}