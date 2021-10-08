import 'package:fast_rsa/rsa.dart';
import 'dart:convert';
class EncryptionHandler {

    Future<String> GeneratePubPrivKeyPair() async{
        var result = await RSA.generate(2048);
        return '';
    }

    String ToBase64(String content){
        return base64.encode(utf8.encode(content));
    }

}