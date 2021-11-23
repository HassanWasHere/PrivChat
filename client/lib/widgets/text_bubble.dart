import 'package:flutter/material.dart';
class Bubble {
    String name;
    String content;

    Bubble(@required this.name, @required this.content);

    @override
    Widget build(BuildContext context) {
        return Container(
            height: MediaQuery.of(context).size.height * .1,
            width: MediaQuery.of(context).size.width * .25,
            padding: new EdgeInsets.all(10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                    //Expanded(
                    //    flex: 3,
                    //    child: Text(this.name)
                    //),
                    Expanded(
                        flex: 10,
                        child: Text(this.content)
                    )
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
                color: Colors.grey,
                borderRadius: BorderRadius.circular(20.0),
            ),
        );
    }
}