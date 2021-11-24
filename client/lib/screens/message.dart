import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import 'transition.dart' as TransitionHandler;
import '../../api/user.dart' as userAPI;
import '../../api/message.dart' as messageAPI;
import '../../objects/client.dart';
import '../../objects/conversation.dart';
import '../../objects/httppostresponse.dart';
import 'messagelist.dart';
import '../../widgets/input_box.dart';
import '../../widgets/text_bubble.dart';

class MessagePage extends StatefulWidget {

    Conversation currentConversation;
    Client thisUser;
    
    MessagePage(@required this.thisUser, @required this.currentConversation, {Key? key}) : super(key: key);

    @override
    _MessagePageWithState createState() =>  _MessagePageWithState();
}


class _MessagePageWithState extends State<MessagePage> {
    final messageBoxController = TextEditingController();

    void sendMessage(BuildContext ctx){
        var content = messageBoxController.text;
        messageAPI.SendMessage(widget.thisUser, widget.currentConversation.other_user, content).then((HttpPostResponse a){});
        setState((){
            widget.currentConversation.addMessage(-1, content, widget.thisUser, widget.currentConversation.other_user);
        });
        
    }

    @override
    Widget build(BuildContext ctx){
        Conversation currentConversation = widget.currentConversation;
        String recipient_name = currentConversation.other_user.username;
        double width;
        if (MediaQuery.of(ctx).size.width > 420){
            width = 420;
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
                                    //padding: EdgeInsets.all(18.0),
                                    child: ListView.builder(
                                        itemCount: currentConversation.messages.length,
                                        reverse: true,
                                        itemBuilder: (context, index) {
                                            var message = currentConversation.messages[index];
                                            print(message.recipient.username);
                                            return Padding(
                                                padding: EdgeInsets.only(bottom: 8),
                                                child: Align(
                                                    child: Bubble(message.sender.username, message.content).build(ctx),
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