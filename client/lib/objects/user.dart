//import '../api/network.dart';
import 'messages.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const String API_ENDPOINT_URL = String.fromEnvironment("GITPOD_WORKSPACE_URL");

class User {
    String username = "ERROR";
    num user_id = -1;

    Future<User> createUserFromID() async {
        user_id = this.user_id;
        final response = await http.get(Uri.parse('$API_ENDPOINT_URL/user?id=$user_id'), 
            headers: <String, String>{
                'Access-Control-Allow-Origin': '*',
            },
        );
        var userData = jsonDecode(response.body);
        this.username = userData.username;
        return this;
    }

    User(user_id) {
        this.user_id = user_id;
    }
}