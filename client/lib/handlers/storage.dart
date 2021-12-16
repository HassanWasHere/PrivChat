import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'encrypt.dart' as encrypt;
/*
    Checks the local storage for a key for the given username.
    Fetches the key then AES decrypts it and returns it.
    If the user doesn't have a key it will throw an error which will
    be handled by the function caller by using .catchError
*/

Future<String> getKey(String username) async { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? key = prefs.getString("KEY_$username");
    if (key != null){
        return await encrypt.AESDecrypt(key as String);
    } else {
        throw Exception("No key");
    }
        
}

/*
    Checks the local storage for a key for the given username.
    Fetches the key then AES decrypts it and returns it.
    If the user doesn't have a key it will throw an error which will
    be handled by the function caller by using .catchError
*/

Future<bool> setKey(String username, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool Response = await prefs.setString("KEY_$username", await encrypt.AESEncrypt(key));
    return true;
}

/*
    Checks the local storage for a cached message for the given message_id.
    Fetches the nmessage then AES decrypts it and returns it.
    If the message doesn't exist it will throw an error which will
    be handled by the function caller by using .catchError
*/

Future<String> getMessage(num message_id) async { 
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? message = prefs.getString("MESSAGE_$message_id");
    if (message != null){
        return await encrypt.AESDecrypt(message as String);
    } else {
        throw Exception("No message");
    }
        
}

/*
    AES encrypts a message then places it in local storage to cache it.
*/

Future<bool> storeMessage(num message_id, String key) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool Response = await prefs.setString("MESSAGE_$message_id", await encrypt.AESEncrypt(key));
    return true;
}
    
