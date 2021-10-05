import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import 'signup.dart';
import 'transition.dart';
class LoginPage extends StatefulWidget {
    
    LoginPage({Key? key}) : super(key: key);

    @override
    _LoginPageWithState createState() =>  _LoginPageWithState();
}


class _LoginPageWithState extends State<LoginPage> {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    void SignupTransition(BuildContext ctx){
        TransitionHandler().Transition(ctx, SignupPage());
    }

    @override
    Widget build(BuildContext ctx){
        return Scaffold(
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
                            InputBox(false, "Username", usernameController).build(ctx),
                            InputBox(true, "Password", passwordController).build(ctx),
                            LargeButton(65.0, double.infinity, "Login", SignupTransition).build(ctx),
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