import 'package:flutter/material.dart';

/* Basic class used to reprsent a large button object used in the UI design
    It has constructors for the height, width, text for the button and the callback.
    The callback is the function that is called when the button has been clicked.
    This is asynchronous programming. We don't want the program to pause execution waiting
    for the button to be clicked.
*/
class LargeButton {
    double height = 65.0;
    double width = double.infinity;
    String text = "ERROR";
    void Function(BuildContext) callback;

    LargeButton(this.height, this.width, this.text, this.callback);

    @override
    Widget build(BuildContext ctx){
        return Container( 
            padding: EdgeInsets.all(8.0),
            width: this.width,
            height: this.height,
            child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.blue,
                child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                    onPressed: (){this.callback(ctx);},
                    child: Text(text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )
                    ),                      
                ),
            )
        );
    }
}
