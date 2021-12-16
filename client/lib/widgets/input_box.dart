import 'package:flutter/material.dart';

/* This class represents an input box.
This input box will be used to allow the user to input data from username and password
to the content of the message the user would like to send
*/

class InputBox {
    bool password = false;
    String hintText = "An error occured";
    TextEditingController controller = TextEditingController();
    double height = 70;
    double width = 360;

    InputBox(this.height, this.width, this.password, this.hintText, this.controller);

    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.all(8.0),
            height: this.height,
            width: this.width,
            child: TextField(
                obscureText: password,
                controller: controller,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                    hintText: hintText,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
                ),
            )
        );
    }
}