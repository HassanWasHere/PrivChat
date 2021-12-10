import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import 'signup.dart';
import 'transition.dart' as TransitionHandler;
import '../../api/user.dart' as userAPI;
import '../../objects/client.dart';
import '../../objects/conversation.dart';
import '../../objects/user.dart';
import '../../objects/websocket.dart';
import 'messagelist.dart';
import 'message.dart';

/*
    The purpose of this page is to allow the user to begin a new conversation.
    The user is able to enter the username of the other user they would like to message,
    the API will check if this user exists or not. If they do, then it will generate a new
    conversation and transition the user to the MessagePage so they can begin
    sending messaging and recieving messages with this user.
*/
class ComposePage extends StatefulWidget {
    Client thisUser;
    WebSocket socket;
    ComposePage(@required this.thisUser, @required this.socket, {Key? key}) : super(key: key);

    @override
    _ComposePageWithState createState() =>  _ComposePageWithState();
}


class _ComposePageWithState extends State<ComposePage> {
    final usernameController = TextEditingController();
    String error = "";
    /*
        This procedure is called when the user presses send message. The procedure
        fetches the username from the username box, checks if the user exists, and if
        they do, then it will transition the user to the message page.
    */
    void MessageUser(BuildContext ctx){
        String username = usernameController.text;
        userAPI.createUserFromUsername(username)
        .then((User other_user){
            Conversation newConversation = Conversation(other_user);
            var messageView = MessagePage(widget.thisUser, newConversation, widget.socket);
            TransitionHandler.Transition(ctx, messageView);
        })
        .catchError((e) {
            setState((){
                error = "User not found";
            });
        });
    }
    /*
        Procedure called to build the UI
    */
    @override
    Widget build(BuildContext ctx){
        

        return Scaffold(
            appBar: AppBar(
                title: Text('Compose Message'),
            ),
            body: Center(
                child: Column(
                    children: <Widget>[
                        InputBox(70, 360, false, "Recipient username", usernameController).build(ctx),
                        Text("$error"),
                        LargeButton(60.0, 240.0, "Message User", MessageUser).build(ctx),
                    ]
                )
            )
        );
    }
}