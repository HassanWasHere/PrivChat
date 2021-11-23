import 'package:fast_rsa/rsa.dart';
import 'dart:convert';
import 'config.dart' as config;
import 'package:cryptography/cryptography.dart';

//class EncryptionHandler {

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



    Future<List<int>> AESEncrypt(String message) async {
        final algorithm = AesCbc.with128bits(
            macAlgorithm: Hmac.sha256(),
        );
        List<int> message_in_bytes = utf8.encode(message);
        List<int> key_in_bytes = utf8.encode(config.SECRET_KEY);
        final secretBox = await algorithm.encrypt(
            message_in_bytes,
            secretKey: SecretKey(key_in_bytes)
        );
        return secretBox.concatenation();
    }

    Future<String> AESDecrypt(List<int> message) async {
        final algorithm = AesCbc.with128bits(
            macAlgorithm: Hmac.sha256(),
        );
        List<int> key_in_bytes = utf8.encode(config.SECRET_KEY);

        SecretBox secretBox = SecretBox.fromConcatenation(
            message,
            nonceLength: 16, 
            macLength: 32,
        );

        SecretKey secretKey = SecretKey(key_in_bytes);

        final final_message = await algorithm.decrypt(
            secretBox,
            secretKey: secretKey
        );
        return utf8.decode(final_message);
    }

//}