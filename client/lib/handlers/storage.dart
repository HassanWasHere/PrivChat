import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'encrypt.dart' as encrypt;

//class StorageHandler {
    Future<String> getKey(String username) async { 
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? key = prefs.getString("KEY_$username");
        if (key != null){
            return await encrypt.AESDecrypt(key as String);
        } else {
            throw Exception("No key");
        }
        
    }

    Future<bool> setKey(String username, String key) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool Response = await prefs.setString("KEY_$username", await encrypt.AESEncrypt(key));
        print("STORED KEY: " + (await prefs.getString("KEY_$username") as String));
        return true;
    }

    
    Future<String> getMessage(num message_id) async { 
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? key = prefs.getString("MESSAGE_$message_id");
        if (key != null){
            return await encrypt.AESDecrypt(key as String);
        } else {
            throw Exception("No key");
        }
        
    }

    Future<bool> storeMessage(num message_id, String key) async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        bool Response = await prefs.setString("MESSAGE_$message_id", await encrypt.AESEncrypt(key));
        print("STORED: " + (await prefs.getString("MESSAGE_$message_id") as String));
        return true;
    }
    

//}