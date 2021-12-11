/* 
    Project: PrivChat
    Application: Client
    File name: user.dart
    Author: Hassan Mahmood
    
    This file provides functions that interact with the REST API user
    endpoint that allows the user id, username and public key to be fetched
    with either a user id or username then create a User class with this
    information



*/

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../objects/messages.dart';
import '../../objects/user.dart';
import '../../objects/client.dart';
import '../../objects/restapiresponse.dart';
import '../../handlers/encrypt.dart';
import '../../handlers/config.dart';
/* 
    Import needed files, this will introduce encryption and configuration 
    functions into the namespace and user, message, client and http response objects.
*/

/*
    This function performs a HTTP POST request to the server with the username, password
    and public key after JSON encoding it.
    It returns a future RESTAPIResponse. A future is an asynchronous programming
    structure. You can use a .then function on the Future which acts as a callback.
    This way the program won't hang while waiting for the response from the web server, instead
    when the response is recieved, the program will move onto the .then callback.
*/

Future<RESTAPIResponse> Signup(String username, String password, String pubkey) async {
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
    return RESTAPIResponse(response.statusCode == 200, response.body);
}

/*
    Sends a HTTP get request to the user endpoint to determine if the username is taken or not
*/

Future<bool> isUsernameAvailable(String username) async {
    final response = await http.get(Uri.parse('$API_ENDPOINT_URL/user?username=$username'), 
        headers: <String, String>{
            'Access-Control-Allow-Origin': '*',
        },
    );
    return response.body.toString() == 'null';
}

/*
    Attempts to fetch user information from the user endpoint using user_id
    Creates a User object using this information.
*/

Future<User> createUserFromID(num user_id) async {
    final response = await http.get(Uri.parse('$API_ENDPOINT_URL/user?id=$user_id'), 
        headers: <String, String>{
            'Access-Control-Allow-Origin': '*',
        },
    );
    var userData = jsonDecode(response.body);
    return User(user_id, userData[0], userData[1]);
}

/*
    Attempts to fetch user information from the user endpoint using username
    Creates a User object using this information.
*/

Future<User> createUserFromUsername(String user_name) async {
    final response = await http.get(Uri.parse('$API_ENDPOINT_URL/user?username=$user_name'), 
        headers: <String, String>{
            'Access-Control-Allow-Origin': '*',
        },
    );
    var userData = jsonDecode(response.body);
    return User(userData[0], user_name, userData[1]);
}

/*
    Attempts to fetch user information from the user endpoint using username
    Creates a Client object using this information. This is different to the User object as it also stores the password
    and doesn't need to store the public key.
*/

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

/*
  This function is a local check on the username and password. This is rechecked
  on the server anyway. But we will check it here first to reduce the number of 
  requests to the server where possible.
*/

bool validCredentials(String username, String password){
  bool isUsernameAvailable = true;
  bool isPasswordAvailable = true;
  RegExp validCharacters = RegExp(r'^[a-zA-Z0-9]+$');
  if (username.length > 10){
    isUsernameAvailable = false;
  };
  if (password.length > 12){
    isPasswordAvailable = false;
  }
  if (!validCharacters.hasMatch(username)){
    isUsernameAvailable = false;
  }
  return (isUsernameAvailable && isPasswordAvailable);
}