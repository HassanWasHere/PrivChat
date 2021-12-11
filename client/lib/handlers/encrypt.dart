import 'package:fast_rsa/rsa.dart';
import 'dart:convert';
import 'config.dart' as config;
import 'package:cryptography/cryptography.dart';

    /*
      This subroutine generates a public and private RSA keypair with the
      key size given in brackets.
    */

    Future<List> GeneratePubPrivKeyPair() async{
        var keyPair = await RSA.generate(1024);
        return [keyPair.privateKey, keyPair.publicKey];
    }

    /*
      RSA encrypt message using message and public key
    */

    Future<String> EncryptMessage(String message, String pubkey){
        return RSA.encryptPKCS1v15(message, pubkey);
    }

    /*
      RSA encrypt message using message and private key
    */

    Future<String> DecryptMessage(String message, String privatekey){
        return RSA.decryptPKCS1v15(message, privatekey);
    }

    /*
      Use program secret key to AES encrypt a message
    */  

    Future<String> AESEncrypt(String message) async {
        final algorithm = AesCbc.with128bits(
            macAlgorithm: Hmac.sha256(),
        );
        /*
          Convert the message and the secret key into bytes to work with.
        */
        List<int> message_in_bytes = utf8.encode(message);
        List<int> key_in_bytes = utf8.encode(config.SECRET_KEY);
        final secretBox = await algorithm.encrypt(
            message_in_bytes,
            secretKey: SecretKey(key_in_bytes)
        );
        /*
          AES encrypt message then return the encrypted message as a string
          The encrypted message is produced by combining the encrypted message, the MAC (message authentication code)
          which is used to verify the authenticity of the message and a nonce key. This is a randomly generated string
          of characters which is used to prevent relay attacks.
          This is when a user tries to brute force the encryption.
        */
        return base64Encode(secretBox.concatenation());
    }

    /*
      Use program secret key to AES decrypt a message
    */  

    Future<String> AESDecrypt(String message) async {
        final algorithm = AesCbc.with128bits(
            macAlgorithm: Hmac.sha256(),
        );
        /*
          Convert the message and the secret key into bytes to work with.
        */
        List<int> key_in_bytes = utf8.encode(config.SECRET_KEY);
        List<int> message_in_bytes = base64Decode(message);
        /*
          The concatentation function called here will split the message back into
          encrypted message, cryptographic nonce and MAC. It will verify the MAC then
          decrypt the message and return it as a string
        */
        SecretBox secretBox = SecretBox.fromConcatenation(
            message_in_bytes,
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
