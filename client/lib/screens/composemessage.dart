import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import 'signup.dart';
import 'transition.dart' as TransitionHandler;
import '../../api/user.dart' as userAPI;
import '../../api/message.dart' as messageAPI;
import '../../objects/client.dart';
import '../../objects/conversation.dart';
import '../../objects/user.dart';
import 'messagelist.dart';
import 'message.dart';
class ComposePage extends StatefulWidget {
    Client thisUser;
    ComposePage(@required this.thisUser, {Key? key}) : super(key: key);

    @override
    _ComposePageWithState createState() =>  _ComposePageWithState();
}


class _ComposePageWithState extends State<ComposePage> {
    final usernameController = TextEditingController();

    void MessageUser(BuildContext ctx){
        String username = usernameController.text;
        userAPI.createUserFromUsername(username).then((User other_user){
            Conversation newConversation = Conversation(other_user);
            var conversationPage = MessagePage(widget.thisUser, newConversation);
            TransitionHandler.Transition(ctx, conversationPage);
        });
    }

    @override
    Widget build(BuildContext ctx){
        return Scaffold(
            body: Center(
                child: Column(
                    children: <Widget>[
                        InputBox(70, 360, false, "Recipient username", usernameController).build(ctx),
                        Text("Hello"),
                        LargeButton(60.0, 60.0, "Message User", MessageUser).build(ctx),
                    ]
                )
            )
        );
    }
}