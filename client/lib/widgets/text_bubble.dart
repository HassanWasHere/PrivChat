import 'package:flutter/material.dart';
/*
    This class represents a chat message bubble that is used to display send/recieved messages
    between users.
    It has three attributes: name, content and colour.
*/

class Bubble {
    String _name;
    String _content;
    bool _isme;
    String _time_sent;

    /* This is the class constructor, it means that the program must specify a name
    which is set to this.name, the message content assigned to this.content and a colour assigned
    to this.colour
    */

    Bubble(@required this._name, @required this._content, @required this._isme, @required this._time_sent);

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
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  this._time_sent,
                  style: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 12.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 6.0),
                Text(
                  this._content,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 14.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            decoration: BoxDecoration(
              color: this._isme ? Colors.green.shade100 : Color(0xFFBEBEBE),
              borderRadius: this._isme
            ? BorderRadius.only(
                topLeft: Radius.circular(15.0),
                bottomLeft: Radius.circular(15.0),
              )
            : BorderRadius.only(
                topRight: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
            ),
          );
    }
}
