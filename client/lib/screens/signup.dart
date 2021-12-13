import 'package:flutter/material.dart';
import '../../widgets/input_box.dart';
import '../../widgets/large_button.dart';
import '../../api/user.dart' as userAPI;
import '../../handlers/encrypt.dart' as encrypt;
import '../../handlers/storage.dart' as storage;
import 'transition.dart' as TransitionHandler;
import 'login.dart';
/* The SignupPage class is the base class for the dynamic signup page.
This class inherits from the 'StatefulWidget' class provided by the Flutter framework allowing it to be dynamic
A dynamic widget is one that can update/change when a variable is changed.
The 'StatefulWidget' class has a createState function that needs to be overriden to
return a State. 
The _SignupPageWithState extends a State object which is what processes the change.
One StatefulWidget can have multiple states, but I only have one in this case.
*/
class SignupPage extends StatefulWidget {
    
    SignupPage({Key? key}) : super(key: key);

    @override
    _SignupPageWithState createState() =>  _SignupPageWithState();
}

class _SignupPageWithState extends State<SignupPage> {

    String labelMessage = "";
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();
    final confirmPasswordController = TextEditingController();
    /*
        This procedure first ensures that the password and confirm password boxes are the same.
        If they are, then the program will next use the UserAPI to confirm if the username is available.
        If the username is available, try fetch a private key for that username, if not found then
        generate the public and private keys, send the username, password and public key to the
        server.
    */
    void SignupRequest(BuildContext ctx){
      var username = usernameController.text;
      var password = passwordController.text;
      if (password == confirmPasswordController.text){
        if (userAPI.validCredentials(username, password)){
            setState(() => labelMessage = "Checking username availibility.." );
            userAPI.isUsernameAvailable(username).then((available){
                if (available){ 
                    setState(() => labelMessage = "Fetching encryption keys.." );
                    storage.getKey(username)
                        .catchError((e) {
                            setState(() => labelMessage = "Generating encryption keys.." );
                            encrypt.GeneratePubPrivKeyPair().then((asd){
                                String privateKey = asd[0];
                                String publicKey = asd[1];
                                print("SENDING PUBLIC KEY TO SERVER $publicKey");
                                storage.setKey(username, privateKey)
                                    .catchError((e){
                                        setState((){
                                            labelMessage = e.toString();
                                        });
                                    })
                                    .then((success){
                                        if (success){
                                            userAPI.Signup(username, password, publicKey)
                                            .then((erg){
                                                setState((){ 
                                                    labelMessage = erg.Content;
                                                });
                                            });
                                        } else {
                                            labelMessage = "An error occurred2";
                                        }
                                        
                                    });
                            });
                        })
                        .then((key){
                            userAPI.Signup(username, password, key)
                                .then((erg){
                                    setState((){
                                        labelMessage = erg.Content;
                                    });
                                });
                        });
                } else {
                    setState((){
                        labelMessage = "Username not available";
                    });
                }
            });
        } else {
            setState((){
                labelMessage = "Invalid username or password";
            });
        }
      } else {
          setState((){
              labelMessage = "Password boxes not matching";
          });   
      }
    }
    /*
        Responsible for allowing transition back to the login screen.
    */
    void LoginTransition(BuildContext ctx){
        TransitionHandler.Transition(ctx, LoginPage());
    }
    /*
        This function is called to build the UI for the application page.
    */
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
                            Text('$labelMessage'),
                            InputBox(70, 360, false, "Username", usernameController).build(ctx),
                            InputBox(70, 360, true, "Password", passwordController).build(ctx),
                            InputBox(70, 360, true, "Confirm Password", confirmPasswordController).build(ctx),
                            SizedBox(height: 15.0),
                            Text("By signing up for this service, you agree to the Terms and Conditions"),
                            SizedBox(height: 15.0),
                            LargeButton(65.0, 360.0, "Sign up", SignupRequest).build(ctx),
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
