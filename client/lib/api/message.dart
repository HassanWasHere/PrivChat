import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../objects/messages.dart';
import '../../objects/httppostresponse.dart';
import '../../handlers/encrypt.dart';

const String API_ENDPOINT_URL = String.fromEnvironment("GITPOD_WORKSPACE_URL");

Future<HttpPostResponse> GetConversations(String username, String password) async {
    final response = await http.get(Uri.parse('$API_ENDPOINT_URL/messages'), 
        headers: <String, String>{
            'Access-Control-Allow-Origin': '*',
            HttpHeaders.authorizationHeader: 'Basic '+ EncryptionHandler().ToBase64("$username:$password"),
        },
    );
    return HttpPostResponse(response.statusCode == 200, response.body);
}

    //Future<bool> SendMessage(String sender_id, String recipient_id, Message message){

    //}
