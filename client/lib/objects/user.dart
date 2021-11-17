//import '../api/network.dart';
import 'messages.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String API_ENDPOINT_URL = String.fromEnvironment("GITPOD_WORKSPACE_URL");

class User {
    num user_id;
    String username;
    String pubkey;
    User(this.user_id, this.username, this.pubkey);
}