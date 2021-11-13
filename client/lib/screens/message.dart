import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import 'transition.dart' as TransitionHandler;
import '../../api/user.dart' as userAPI;
import '../../api/message.dart' as messageAPI;
import '../../objects/client.dart';
import '../../objects/conversation.dart';
import 'messagelist.dart';
class MessagePage extends StatefulWidget {
    
    MessagePage({Key? key}) : super(key: key);

    Conversation? currentConversation;

    void setConversation(Conversation conversation){
        currentConversation = conversation;
    }

    @override
    _MessagePageWithState createState() =>  _MessagePageWithState();
}


class _MessagePageWithState extends State<MessagePage> {

    @override
    Widget build(BuildContext ctx){
        Conversation currentConversation = widget.currentConversation as Conversation;
        print(currentConversation.messages.length);
        return Scaffold(
            body: Container (
                padding: EdgeInsets.all(36.0),
                child: Column (
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                        Container(
                            height: 120.0,
                            width: 240.0,
                            child: ListView.builder(
                                itemCount: currentConversation.messages.length,
                                itemBuilder: (context, index) {
                                    var message = currentConversation.messages[index];
                                    return ListTile(
                                        title: Text(message.sender.username),
                                        subtitle: Text(message.content),
                                        tileColor: Colors.green,
                                        minLeadingWidth: 10,
                                    );
                                }
                            ) 
                        )
                            
                    ]
                )
            )
        );
    }
}