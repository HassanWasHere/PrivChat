import 'package:fast_rsa/rsa.dart';
import 'dart:convert';
class EncryptionHandler {

    Future<List> GeneratePubPrivKeyPair() async{
        var keyPair = await RSA.generate(2048);
        return [keyPair.privateKey, keyPair.publicKey];
    }

    Future<String> EncryptMessage(String message, String pubkey){
        return RSA.decryptPKCS1v15(message, pubkey);
    }

    String ToBase64(String content){
        return base64.encode(utf8.encode(content));
    }

}