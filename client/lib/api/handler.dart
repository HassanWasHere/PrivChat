import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetHandler {
    final String API_ENDPOINT_URL = "http://127.0.0.1:8080";

    Future<bool> Signup(String username, String password) async {
        final response = await http.post(Uri.parse('https://reqbin.com/echo/post/json'), 
            headers: <String, String>{
                'Content-Type': 'application/json',
                "Access-Control-Allow-Origin": "*",
            },
            body: jsonEncode(<String, String>{
                'username': username,
                'password': password,
                'pubkey': "toimplement"
            })
        );
        debugPrint('movieTitle: $response.body');
        return (response.statusCode == 200);
    }


    
}