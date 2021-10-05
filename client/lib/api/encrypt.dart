import 'package:fast_rsa/rsa.dart';
class EncryptionHandler {

    Future<String, String> GeneratePubPrivKeyPair(){
        var result = await RSA.generate(2048);
        
    }

}