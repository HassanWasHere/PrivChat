import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../objects/messages.dart';
import 'encrypt.dart';

class HttpPostResponse {
    bool Success = false;
    String ErrorMessage = '';
    HttpPostResponse(this.Success, this.ErrorMessage);
}


class NetHandler {
    final String API_ENDPOINT_URL = "https://8080-pink-rodent-nhjr1pzu.ws-eu18.gitpod.io";

    Future<HttpPostResponse> Signup(String username, String password) async {
        final response = await http.post(Uri.parse('$API_ENDPOINT_URL/signup'), 
            headers: <String, String>{
                'Content-Type': 'application/json',
                'Access-Control-Allow-Origin': '*',
            },
            body: jsonEncode(<String, String>{
                'username': username,
                'password': password,
                'pubkey': "NOT_IMPL"
            })
        );
        return HttpPostResponse(response.statusCode == 200, response.body);
    }

    Future<HttpPostResponse> GetConversations(String username, String password) async {
        final response = await http.get(Uri.parse('$API_ENDPOINT_URL/messages'), 
            headers: <String, String>{
                'Access-Control-Allow-Origin': '*',
                HttpHeaders.authorizationHeader: 'Basic '+ EncryptionHandler().ToBase64("$username:$password"),
            },
        );
        return HttpPostResponse(response.statusCode == 200, response.body);
    }

    //Future<bool> Login(String username, String password) async {

    //}

    //Future<bool> SendMessage(String sender_id, String recipient_id, Message message){

    //}

    
}