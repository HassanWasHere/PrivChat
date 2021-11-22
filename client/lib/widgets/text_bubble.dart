import 'package:flutter/material.dart';
class Bubble {
    String name;
    String content;
    bool isme;

    Bubble(@required this.name, @required this.content, @required this.isme);

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 60,
            width: 150,
            padding: new EdgeInsets.all(10.0),
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
                color: Colors.green,
                borderRadius: BorderRadius.circular(20.0),
            ),
        );
    }
}