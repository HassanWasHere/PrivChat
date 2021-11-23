import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import '../../api/user.dart' as userAPI;
import '../../handlers/encrypt.dart' as encrypt;
import 'transition.dart' as TransitionHandler;
import 'login.dart';
class SignupPage extends StatefulWidget {
    
    SignupPage({Key? key}) : super(key: key);

    @override
    _SignupPageWithState createState() =>  _SignupPageWithState();
}

class _SignupPageWithState extends State<SignupPage> {
    String errorMessage = "";
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    //final EncryptionHandler = EncryptionHandler();
    void SignupRequest2(BuildContext ctx){
        encrypt.AESEncrypt("hello").then((encryptedmessage){
            encrypt.AESDecrypt(encryptedmessage).then( (decryptedmessage){
                setState( () => errorMessage = decryptedmessage);
            });
        });
    }

    void SignupRequest(BuildContext ctx){
        if (passwordController.text == confirmPasswordController.text){
            userAPI.Signup(usernameController.text, passwordController.text, "fornow").then((erg) => setState(()=> errorMessage = erg.ErrorMessage));
        } else {
            setState(() => errorMessage = "not matching");
        }
    }

    void LoginTransition(BuildContext ctx){
        TransitionHandler.Transition(ctx, LoginPage());
    }
    void donothing(BuildContext ctx){}

    @override
    Widget build(BuildContext ctx){
        return Scaffold(
            appBar: AppBar(
                title: Text('Signup'),
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
                            Text('$errorMessage'),
                            InputBox(70, 360, false, "Username", usernameController).build(ctx),
                            InputBox(70, 360, true, "Password", passwordController).build(ctx),
                            InputBox(70, 360, true, "Confirm Password", confirmPasswordController).build(ctx),
                            SizedBox(height: 15.0),
                            Text("By signing up for this service, you agree to the Terms and Conditions"),
                            SizedBox(height: 15.0),
                            LargeButton(65.0, double.infinity, "Sign up", SignupRequest2).build(ctx),
                            SizedBox(height: 10.0),
                            Text("Already a user?"),
                            LargeButton(65.0, 240.0, "Login", LoginTransition).build(ctx),
                        ]
                    )
                )
            )
        );
    }
}
