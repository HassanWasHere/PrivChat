import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import 'transition.dart' as TransitionHandler;
import '../../api/user.dart' as userAPI;
import '../../objects/client.dart';
import '../../objects/conversation.dart';
import '../../objects/websocket.dart';
import 'messagelist.dart';
import '../../widgets/input_box.dart';
import '../../widgets/text_bubble.dart';
import '../../handlers/encrypt.dart';
import '../../handlers/storage.dart';

/*
    The MessagePage and MessgePageWithState classes here are used to create the Message view page.  
    This page is responsible for showing all messages in a conversation and allowing the user
    to send a message to the other user in the conversation.
*/

class MessagePage extends StatefulWidget {
    /* 
        currentConversation represents the conversation this view is displaying. 
        The constructor requires the conversation, the currently logged in user and the websocket.
    */
    Conversation currentConversation;
    Client thisUser;
    WebSocket socket;
    
    MessagePage(@required this.thisUser, @required this.currentConversation, @required this.socket, {Key? key}) : super(key: key);

    @override
    _MessagePageWithState createState() =>  _MessagePageWithState();

    
}


class _MessagePageWithState extends State<MessagePage> {
    final messageBoxController = TextEditingController();
    /*
        initialiseSocket makes the WebSocket listen for a new message request.
        When the server sends the new message request, this function will check
        if the sender of the message is the user this conversation is with.
        If this is the case, the message will be decrypted then added into the
        current conversation using setState to tell the UI to update.
    */
    void initaliseSocket(){
        widget.socket.get_socket().on("message", (data){
            var other_user = widget.currentConversation.get_other_user();
            if (data[0] == other_user.get_user_id()){
                getKey(widget.thisUser.get_username()).then((privateKey){
                    var a = data[1];
                    DecryptMessage(data[1], privateKey)
                    .then((content){
                        setState( (){
                            widget.currentConversation.add_message(-1, content, other_user, widget.thisUser, DateTime.now().millisecondsSinceEpoch);
                        });
                    })
                    .catchError((e){
                        setState( () => widget.currentConversation.add_message(-1, e.cause, other_user, widget.thisUser, DateTime.now().millisecondsSinceEpoch));
                    });
                });
                
            }
        });
    }
    /*
        This procedure is responsible for encrypting the message typed in the
        message box then storing the message in local storage so it can be displayed
        later and then sending it to the server through the WebSocket.
    */

    void sendMessage(BuildContext ctx){
        var other_user = widget.currentConversation.get_other_user();
        var key = other_user.get_pubkey();
        var original_message = messageBoxController.text;
        EncryptMessage(original_message, key)
        .then((content){
            print(content);
            print(key);
            print(other_user.get_user_id());
            widget.socket.get_socket().emitWithAck("message", [other_user.get_user_id(), content], ack: (message_id){
                storeMessage(message_id, original_message);
                setState((){
                    widget.currentConversation.add_message(message_id, original_message, widget.thisUser, other_user, DateTime.now().millisecondsSinceEpoch);
                });
            });
            
        })
        .catchError((err){
            print(err.cause.toString());
        });
    }

    /*
        When the page state is created, initialise the socket.
    */

    void initState(){
        this.initaliseSocket();
    }

    /*
        Build the UI for the application.
    */

    @override
    Widget build(BuildContext ctx){
        Conversation currentConversation = widget.currentConversation;
        var recipient = currentConversation.get_other_user();
        String recipient_name = recipient.get_username();
        double width;
        if (MediaQuery.of(ctx).size.width > 560){
            width = 560;
        } else {
            width = MediaQuery.of(ctx).size.width;
        }
        return Scaffold(
            appBar: AppBar(
                title: Row(
                    children: <Widget>[
                        Text('Conversation with $recipient_name'),
                    ]
                )
            ),
            body: Center(
                child: Container (
                    padding: EdgeInsets.only(bottom: 36.0, top: 36.0),
                    child: Column (
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Expanded(
                                flex: 8,
                                child: Container(
                                    height: 240.0,
                                    width: width,
                                    child: ListView.builder(
                                        itemCount: currentConversation.get_messages().length,
                                        reverse: true,
                                        itemBuilder: (context, index) {
                                            var message = currentConversation.get_messages()[currentConversation.get_messages().length-1-index];
                                            var sender = message.get_sender();
                                            var isme = sender.get_user_id() == widget.thisUser.get_user_id();
                                            return Padding(
                                                padding: EdgeInsets.only(bottom: 8),
                                                child: Align(
                                                    child: Bubble(sender.get_username(), message.get_content(), isme, message.get_time_sent()).build(ctx),
                                                    alignment: isme ? Alignment.topRight : Alignment.topLeft,
                                                )
                                            );
                                        }
                                    ),
                                ),
                            ),
                            Expanded(
                                flex: 1,
                                child: InputBox(70, 360, false, "Send Message", messageBoxController).build(ctx),
                            ),
                            Expanded(
                                flex: 1,
                                child: LargeButton(60.0, 60.0, "->", sendMessage).build(ctx),
                            )
                        ]
                    )
                )
            )
        );
    }
}