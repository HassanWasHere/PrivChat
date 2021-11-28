import 'package:flutter/material.dart';
import '../objects/conversation.dart';
import 'dart:convert';
import '../objects/user.dart';
import '../objects/messages.dart';
import '../objects/client.dart';
import '../objects/websocket.dart';
import '../../widgets/large_button.dart';
import '../api/user.dart' as UserAPI;
import 'transition.dart' as TransitionHandler;
import 'message.dart';
import 'composemessage.dart';
class MessageListPage extends StatefulWidget {

    String Response;
    WebSocket socket;
    Client thisUser;

    MessageListPage(@required this.thisUser, @required this.Response, @required this.socket, {Key? key}) : super(key: key);

    
    @override
    _MessageListPageWithState createState() =>  _MessageListPageWithState();
}


class _MessageListPageWithState extends State<MessageListPage> {
    var Conversations = <Conversation>[];
    String test = '';
    void loadConversations(String data, _){
        Conversations = <Conversation>[];
        var conversationsJSON = jsonDecode(data);
        print(conversationsJSON.toString());
        conversationsJSON.forEach((other_user_id, message_list){
            UserAPI.createUserFromID(int.parse(other_user_id)).then((otherUser){
                var newConversation = Conversation(otherUser);
                message_list.forEach((message){
                    User sender;
                    User recipient;
                    print("OTHER USER: $other_user_id");
                    print("SENDER: $message['sender_id']");
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
        loadConversations(widget.Response, null);
        widget.socket.updateMessageCallback = loadConversations;
    }

    void showConversation(BuildContext ctx, Conversation conversation){
        var conversationPage = MessagePage(widget.thisUser, conversation, widget.socket);
        TransitionHandler.Transition(ctx, conversationPage);
    }

    void createMessage(BuildContext ctx){
        var composePage = ComposePage(widget.thisUser, widget.socket);
        TransitionHandler.Transition(ctx, composePage);
    }
    Widget build(BuildContext ctx){
        return Scaffold(
            appBar: AppBar(
                title: Text('All conversations'),
            ),
            body: Container(
                padding: EdgeInsets.all(36.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Container(
                            width: double.infinity,
                            height: MediaQuery.of(ctx).size.height * 0.75,
                            child:ListView.builder(
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
                                        subtitle: Text(messageContent),
                                        onTap: (){showConversation(ctx, conversation);}
                                    );
                                },
                            ),
                        ),
                        LargeButton(60.0, 60.0, "+", createMessage).build(ctx),
                    ]  
                ) 
            ),
        );
    }
}