import 'package:flutter/material.dart';

class InputBox {
    bool password = false;
    String hintText = "An error occured";
    TextEditingController controller = TextEditingController();

    InputBox(bool password, String hintText, TextEditingController controller){
        this.password = password;
        this.hintText = hintText;
        this.controller = controller;
    }
    @override
    Widget build(BuildContext context) {
        return Container(
            padding: EdgeInsets.all(8.0),
            height: 70,
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