import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../objects/messages.dart';
import '../../objects/user.dart';
import '../../objects/client.dart';
import '../../objects/httppostresponse.dart';
import '../../handlers/encrypt.dart';

const String API_ENDPOINT_URL = String.fromEnvironment("GITPOD_WORKSPACE_URL");

Future<HttpPostResponse> Signup(String username, String password, String pubkey) async {
    final response = await http.post(Uri.parse('$API_ENDPOINT_URL/signup'), 
        headers: <String, String>{
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
        },
        body: jsonEncode(<String, String>{
            'username': username,
            'password': password,
            'pubkey': pubkey,
        })
    );
    return HttpPostResponse(response.statusCode == 200, response.body);
}


Future<User> createUserFromID(num user_id) async {
    final response = await http.get(Uri.parse('$API_ENDPOINT_URL/user?id=$user_id'), 
        headers: <String, String>{
            'Access-Control-Allow-Origin': '*',
        },
    );
    var userData = jsonDecode(response.body);
    return User(user_id, userData[0], "fornow");
}

Future<User> createUserFromUsername(String user_name) async {
    final response = await http.get(Uri.parse('$API_ENDPOINT_URL/user?username=$user_name'), 
        headers: <String, String>{
            'Access-Control-Allow-Origin': '*',
        },
    );
    var userData = jsonDecode(response.body);
    return User(userData[0], user_name, "fornow");
}

Future<Client> createClientFromUsernameAndPassword(String user_name, String password) async {
    final response = await http.get(Uri.parse('$API_ENDPOINT_URL/user?username=$user_name'), 
        headers: <String, String>{
            'Access-Control-Allow-Origin': '*',
        },
    );
    try{
        var userData = jsonDecode(response.body);
        return Client(user_name, password, userData[0]);
    } catch(e){
        throw Exception('User not found');
    }
    
}
