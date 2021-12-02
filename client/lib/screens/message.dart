import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import 'transition.dart' as TransitionHandler;
import '../../api/user.dart' as userAPI;
import '../../api/message.dart' as messageAPI;
import '../../objects/client.dart';
import '../../objects/conversation.dart';
import '../../objects/websocket.dart';
import '../../objects/httppostresponse.dart';
import 'messagelist.dart';
import '../../widgets/input_box.dart';
import '../../widgets/text_bubble.dart';
import '../../handlers/encrypt.dart';
import '../../handlers/storage.dart';

class MessagePage extends StatefulWidget {

    Conversation currentConversation;
    Client thisUser;
    WebSocket socket;
    
    MessagePage(@required this.thisUser, @required this.currentConversation, @required this.socket, {Key? key}) : super(key: key);

    @override
    _MessagePageWithState createState() =>  _MessagePageWithState();

    
}


class _MessagePageWithState extends State<MessagePage> {
    final messageBoxController = TextEditingController();

    void initaliseSocket(){
        widget.socket.sock?.on("message", (data){
            if (data[0] == widget.currentConversation.other_user.user_id){
                getKey(widget.thisUser.username).then((privateKey){
                    var a = data[1];
                    DecryptMessage(data[1], privateKey)
                    .then((content){
                        setState( (){
                            widget.currentConversation.addMessage(-1, content, widget.currentConversation.other_user, widget.thisUser);
                        });
                    })
                    .catchError((e){
                        setState( () => widget.currentConversation.addMessage(-1, e.cause, widget.currentConversation.other_user, widget.thisUser));
                    });
                });
                
            }
        });
    }

    void sendMessage(BuildContext ctx){
        var key = widget.currentConversation.other_user.pubkey;
        var original_message = messageBoxController.text;
        EncryptMessage(original_message, key)
        .then((content){
            widget.socket.sock?.emitWithAck("message", [widget.currentConversation.other_user.user_id, content], ack: (message_id){
                storeMessage(message_id, original_message);
                setState((){
                    widget.currentConversation.addMessage(message_id, original_message, widget.thisUser, widget.currentConversation.other_user);
                });
            });
            
        })
        .catchError((err){
            print(err.cause.toString());
        });
    }

    void initState(){
        this.initaliseSocket();
    }

    @override
    Widget build(BuildContext ctx){
        Conversation currentConversation = widget.currentConversation;
        String recipient_name = currentConversation.other_user.username;
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
                    padding: EdgeInsets.all(36.0),
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
                                        itemCount: currentConversation.messages.length,
                                        reverse: true,
                                        itemBuilder: (context, index) {
                                            var message = currentConversation.messages[currentConversation.messages.length-1-index];
                                            var colour = message.sender.user_id == widget.thisUser.user_id ? Colors.white : Colors.green.shade200;
                                            return Padding(
                                                padding: EdgeInsets.only(bottom: 8),
                                                child: Align(
                                                    child: Bubble(message.sender.username, message.content, colour).build(ctx),
                                                    alignment: message.sender.user_id == widget.thisUser.user_id ? Alignment.topRight : Alignment.topLeft,
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