import 'package:flutter/material.dart';
class Bubble {
    String name;
    String content;
    bool isme;

    Bubble(@required this.name, @required this.content, @required this.isme);

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 50,
            width: 10,//MediaQuery.of(context).size.width * .3,
            child: Column(
                crossAxisAlignment: isme ? CrossAxisAlignment.start : CrossAxisAlignment.end,
                children: <Widget>[
                    Text(this.name),
                    Text(this.content)
                ]
            ),
            decoration: BoxDecoration(
                boxShadow: [
                    BoxShadow(
                        blurRadius: .5,
                        spreadRadius: 1.0,
                        color: Colors.black.withOpacity(.12)
                    )
                ],
                color: Colors.green,//this.isme ? Colors.white : Colors.greenAccent.shade100,
                //borderRadius: BorderRadius.all(5.0),
            ),
        );
    }
}