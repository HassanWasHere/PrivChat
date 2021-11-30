import 'package:flutter/material.dart';
class Bubble {
    String name;
    String content;
    Color colour;

    Bubble(@required this.name, @required this.content, @required this.colour);

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
