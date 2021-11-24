import 'package:flutter/material.dart';
class Bubble {
    String name;
    String content;

    Bubble(@required this.name, @required this.content);

    @override
    Widget build(BuildContext context) {
        return FractionallySizedBox(
            widthFactor: 0.4,
            heightFactor: 0.2,
            child: Container(
                //height: MediaQuery.of(context).size.height * .1,
                //width: MediaQuery.of(context).size.width * .3,
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
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(MediaQuery.of(context).size.height * .25),
                ),
            )
        );
    }
}