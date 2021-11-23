import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'encrypt.dart' as encrypt;

class StorageHandler {
    Future<dynamic> getKey async (String username){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        String? key = prefs.getString("KEY_$username");
        if (key != null){
            return encrypt.AESDecrypt(key);
        } else {
            return false;
        }
    }

    Future<void> setKey async (String username, String key){
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("KEY_$username", encrypt.AESEncrypt(key));
    }

}