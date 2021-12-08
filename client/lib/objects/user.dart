//import '../api/network.dart';
import 'messages.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class User {
    num _user_id;
    String _username;
    String _pubkey;
    User(this._user_id, this._username, this._pubkey);

    num get_user_id(){
        return this._user_id;
    }
    String get_username(){
        return this._username;
    }
    String get_pubkey(){
        return this._pubkey;
    }
}