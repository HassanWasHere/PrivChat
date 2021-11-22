import 'package:flutter/material.dart';
class Bubble {
    String name;
    String content;

    Bubble(@required this.name, @required this.content);

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 50,
            width: 150,
            padding: new EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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