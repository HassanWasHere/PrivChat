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
import '../handlers/encrypt.dart';
import '../handlers/storage.dart';
/*
    These classes are responsible for building a dynamic message page.
    The message page needs to be dynamic so new conversations and messages can be 
    shown to the user. 
*/
class MessageListPage extends StatefulWidget {

    /* 
        Response is the result from the login screen after fetching conversations through the 
        websocket by sending 'Conversations'. 
        This response data is then JSON decoded and parsed. 
        Conversations and messages are created using this data. 
        Socket represents the WebSocket where data is sent between the sevrer and the client.
        thisUser represents the user that is currently logged in.
    */
    String Response;
    WebSocket socket;
    Client thisUser;

    MessageListPage(@required this.thisUser, @required this.Response, @required this.socket, {Key? key}) : super(key: key);

    
    @override
    _MessageListPageWithState createState() =>  _MessageListPageWithState();
}


class _MessageListPageWithState extends State<MessageListPage> {
    var Conversations = <Conversation>[];
    /*
        The loadConversations procedure is responsible for parsing the message data
        It creates conversation objects, filled with message objects.
        When adding a new conversation to the list, we call setState() so that the UI knows it needs to
        update.
        For each message, we first see if the message exists in cached form in local storage. If it does exist then
        
    */
    void loadConversations(String data, _){
        Conversations = <Conversation>[];
        var conversationsJSON = jsonDecode(data);
        getKey(widget.thisUser.username).then((privateKey){
            conversationsJSON.forEach((other_user_id, message_list){
                UserAPI.createUserFromID(int.parse(other_user_id)).then((otherUser){
                    var newConversation = Conversation(otherUser);
                    message_list.forEach((message){
                        var sender_id = message['sender_id'];
                        var time_sent = message['time_sent'];
                        getMessage(message['message_id'])
                        .then((alreadycontent){
                            if (other_user_id.toString() == message['sender_id'].toString()){
                                setState( () => newConversation.add_message(message['message_id'], alreadycontent, otherUser, widget.thisUser, time_sent));
                            } else {
                                setState( () => newConversation.add_message(message['message_id'], alreadycontent, widget.thisUser, otherUser, time_sent));
                            };
                        })
                        .catchError((e){
                            DecryptMessage(message['content'], privateKey)
                            .then((content){
                                storeMessage(message['message_id'], content);
                                if (other_user_id.toString() == message['sender_id'].toString()){
                                    setState( () => newConversation.add_message(message['message_id'], content, otherUser, widget.thisUser, time_sent));
                                } else {
                                    setState( () => newConversation.add_message(message['message_id'], content, widget.thisUser, otherUser, time_sent));
                                };
                            })
                            .catchError((e){
                                setState( () => newConversation.add_message(message['message_id'], e.cause, otherUser, widget.thisUser, time_sent));
                            });
                        });
                        
                    });
                    setState( (){
                        Conversations.add(newConversation);
                    });
                });
            });
        });
        
    }
    /*
        This is called when the state is created. This is here instead of build so these aren't called everytime the UI needs to be updated.
        This will load the conversations and make it so when the WebSocket returns the conversation data, loadConversations is called
    */
    void initState(){
        super.initState();
        loadConversations(widget.Response, null);
        widget.socket.updateMessageCallback = loadConversations;
    }
    // This procedure will make the program move onto the Message view page
    void showConversation(BuildContext ctx, Conversation conversation){
        var conversationPage = MessagePage(widget.thisUser, conversation, widget.socket);
        TransitionHandler.Transition(ctx, conversationPage);
    }
    // This procedure will make the program move onto the new Message view page
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
                            child: ListView.builder(
                            itemCount: Conversations.length,
                                itemBuilder: (context, index) {
                                    var conversation = Conversations[index];
                                    var other_user = conversation.get_other_user();
                                    var messages = conversation.get_messages();
                                    String messageContent;
                                    if (messages.length == 0){
                                        messageContent = "No messages sent to this user";
                                    } else {
                                        messageContent = messages[messages.length-1].get_content();
                                    }
                                    
                                    return ListTile(
                                        title: Text(other_user.get_username()),
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