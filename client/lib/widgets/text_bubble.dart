import 'package:flutter/material.dart';
/*
    This class represents a chat message bubble that is used to display send/recieved messages
    between users.
    It has three attributes: name, content and colour.
*/

class Bubble {
    String name;
    String content;
    Color colour;

    /* This is the class constructor, it means that the program must specify a name
    which is set to this.name, the message content assigned to this.content and a colour assigned
    to this.colour
    */

    Bubble(@required this.name, @required this.content, @required this.colour);

    /* Build function called to actually allow the UI to be drawn on the screen
    It must return a widget, in this case a Container object that is then shown on
    the user's screen within the page that is creating it.
    */
    @override
    Widget build(BuildContext context) {
        double width = MediaQuery.of(context).size.width*.4;
        if (width > 250){
            width = 250;
        }
        return Container(
            height: MediaQuery.of(context).size.height * .075,
            width: width,
            child: Align(
                alignment: Alignment.center,
                child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                        this.content,
                        style: TextStyle(fontSize: 14),
                    )
                )
            ),
            decoration: BoxDecoration(
                boxShadow: [
                    BoxShadow(
                        blurRadius: .5,
                        spreadRadius: 1.0,
                        color: Colors.black.withOpacity(.12)
                    )
                ],
                color: this.colour,
                borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * .25),
            ),
        );
    }
}
