import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../objects/messages.dart';
import '../../objects/user.dart';
import '../../objects/httppostresponse.dart';
import '../../handlers/encrypt.dart';
import '../objects/client.dart';

const String API_ENDPOINT_URL = String.fromEnvironment("GITPOD_WORKSPACE_URL");

Future<HttpPostResponse> GetConversations(Client user) async {
    var username = user.username;
    var password = user.password;
    final response = await http.get(Uri.parse('$API_ENDPOINT_URL/messages'), 
        headers: <String, String>{
            'Access-Control-Allow-Origin': '*',
            HttpHeaders.authorizationHeader: 'Basic '+ EncryptionHandler().ToBase64("$username:$password"),
        },
    );
    return HttpPostResponse(response.statusCode == 200, response.body);
}

Future<HttpPostResponse> SendMessage(Client user, User recipient, String content) async {
    var username = user.username;
    var password = user.password;
    final response = await http.post(Uri.parse('$API_ENDPOINT_URL/messages'), 
        headers: <String, String>{
            'Content-Type': 'application/json',
            'Access-Control-Allow-Origin': '*',
            HttpHeaders.authorizationHeader: 'Basic '+ EncryptionHandler().ToBase64("$username:$password"),
        },
        body: jsonEncode(<String, dynamic>{
            'recipient_id': recipient.user_id,
            'content': content
        })
    );
    return HttpPostResponse(response.statusCode == 200, response.body);
}