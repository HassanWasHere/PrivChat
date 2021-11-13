import 'package:flutter/material.dart';
import '../objects/conversation.dart';
import 'dart:convert';
import '../objects/user.dart';
import '../objects/messages.dart';
import '../objects/client.dart';
import '../api/user.dart' as UserAPI;
import 'transition.dart' as TransitionHandler;
import 'message.dart';
class MessageListPage extends StatefulWidget {
    MessageListPage({Key? key}) : super(key: key);

    String Response = '';
    Client thisUser = Client("ERROR", "ERROR", -2);

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
    String test = '';
    void loadConversations(){
        var conversationsJSON = jsonDecode(widget.Response);
        conversationsJSON.forEach((other_user_id, message_list){
            UserAPI.createUserFromID(int.parse(other_user_id)).then((otherUser){
                var newConversation = Conversation(otherUser);
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
                });
                setState( () => Conversations.add(newConversation));
            });
        });
    }
    void initState(){
        super.initState();
        loadConversations();
    }

    void showConversation(BuildContext ctx, Conversation conversation){
        var conversationPage = MessagePage();
        conversationPage.setConversation(conversation);
        TransitionHandler.Transition(ctx, conversationPage);
    }
    Widget build(BuildContext ctx){
        print("BUILDING " + Conversations.length.toString());
        return Scaffold(
            body: ListView.builder(
                itemCount: Conversations.length,
                itemBuilder: (context, index) {
                    var conversation = Conversations[index];
                    print(Conversations.length);
                    String messageContent;
                    if (conversation.getMessages().length == 0){
                        messageContent = "No messages sent to this user";
                    } else {
                        messageContent = conversation.getMessages()[0].content;
                    }
                    
                    return ListTile(
                        title: Text(conversation.other_user.username),
                        subtitle: Text(messageContent),
                        onTap: (){showConversation(ctx, conversation);}
                    );
                },
            ),
        ); 
    }
}