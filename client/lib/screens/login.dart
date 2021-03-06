import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import 'signup.dart';
import 'transition.dart' as TransitionHandler;
import '../../api/user.dart' as userAPI;
import '../../objects/client.dart';
import '../../objects/websocket.dart';
import 'messagelist.dart';

/*
    The LoginPage class is responsible for presenting the user with the login screen. 
*/


class LoginPage extends StatefulWidget {
    
    LoginPage({Key? key}) : super(key: key);

    @override
    _LoginPageWithState createState() =>  _LoginPageWithState();
}


class _LoginPageWithState extends State<LoginPage> {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    String labelMessage = "";

    /* 
        The SignupTransition procedure allows the program to transition to the signup screen
    */

    void SignupTransition(BuildContext ctx){
        TransitionHandler.Transition(ctx, SignupPage());
    }

    /* 
        The MessageListTransition procedure allows the program to transition to the message list screen
        where all the conversations will be displayed. The program will pass through the JSON
        data is has recieved from the server through the WebSocket.
    */

    void MessageListTransition(BuildContext ctx, Client thisUser, String Response, WebSocket socket){
        MessageListPage page = MessageListPage(thisUser, Response, socket);
        TransitionHandler.Transition(ctx, page);
    }

    /* 
        This procedure is called when the user presses the login button. A user object is created to 
        represent the user using the specified username and password. A WebSocket is then created and
        when the conversation data is recieved, it will transition to the MessageList page. 
    */

    void ProcessLogin(BuildContext ctx){
        if (userAPI.validCredentials(usernameController.text, passwordController.text)){
          print("VALID CRED");
          userAPI.createClientFromUsernameAndPassword(usernameController.text, passwordController.text).then((thisUser){
            WebSocket(thisUser, (String data, WebSocket self){
                MessageListTransition(ctx, thisUser, data, self);
            });
          }).catchError((e){
            setState(() => labelMessage = e.toString());
          });
        } else {
            setState(() => labelMessage = "Invalid username or password");
        }
        
    }

    @override
    Widget build(BuildContext ctx){
        return Scaffold(
            appBar: AppBar(
                title: Text('Login'),
            ),
            body: Center(
                child: Container (
                    padding: EdgeInsets.all(36.0),
                    child: Column (
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                            Container(
                                height: 120.0,
                                width: 240.0,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/logo1.png'
                                        ),
                                        fit: BoxFit.fill,
                                    ),
                                )
                            ),
                            SizedBox(height: 36.0),
                            Text("$labelMessage"),
                            InputBox(70, 360, false, "Username", usernameController).build(ctx),
                            InputBox(70, 360, true, "Password", passwordController).build(ctx),
                            LargeButton(65.0, 360.0, "Login", ProcessLogin).build(ctx),
                            SizedBox(height: 10.0),
                            Text("Not a user yet?"),
                            LargeButton(65.0, 240.0, "Sign up", SignupTransition).build(ctx),
                        ]
                    )
                )
            )
        );
    }
}