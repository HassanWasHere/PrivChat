import "signup.dart";
import "login.dart";
import "messagelist.dart";
import 'package:flutter/material.dart';

/*
    This transition function is to allow the program to switch between different pages of the application.
    It uses the built in Navigator object to create a new Page then go to it.
    The function has two parameters, the buildcontext, representing the page that's requesting the change
    and, the page, which represents the page the user would like to switch to.
*/

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