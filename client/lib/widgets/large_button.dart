import 'package:flutter/material.dart';
class LargeButton {
    double height = 65.0;
    double width = double.infinity;
    String text = "ERROR";

    LargeButton(double height, double width, String text){
        this.height = height;
        this.width = width;
        this.text = text;
    }

    @override
    Widget build(BuildContext ctx){
        return Container( 
            padding: EdgeInsets.all(8.0),
            width: this.width,
            height: this.height,
            child: Material(
                elevation: 10.0,
                borderRadius: BorderRadius.circular(30.0),
                color: Colors.blue,
                child: MaterialButton(
                    padding: EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0),
                    onPressed: (){},
                    child: Text(text,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        )
                    ),
                                            
                ),
            )
        );
    }
}
