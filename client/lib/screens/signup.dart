import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
class SignupPage extends StatefulWidget {
    
    SignupPage({Key? key}) : super(key: key);

    @override
    _SignupPageWithState createState() =>  _SignupPageWithState();
}

class _SignupPageWithState extends State<SignupPage> {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    void donothing(){}

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
                            InputBox(true, "Confirm Password", confirmPasswordController).build(ctx),
                            LargeButton(65.0, double.infinity, "Sign up", donothing).build(ctx),
                            SizedBox(height: 10.0),
                            Text("Already a user?"),
                            LargeButton(65.0, 240.0, "Login", donothing).build(ctx),
                        ]
                    )
                )
            )
        );
    }
}
