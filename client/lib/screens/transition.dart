import "signup.dart";
import "login.dart";
import "messagelist.dart";
import 'package:flutter/material.dart';
class TransitionHandler {
    void Transition(BuildContext ctx, Widget page) {
         Navigator.of(ctx).push(
            PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) => page,
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return child;
                },
            )
        );
    }

}