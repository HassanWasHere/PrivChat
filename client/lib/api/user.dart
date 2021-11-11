import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../objects/messages.dart';
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
