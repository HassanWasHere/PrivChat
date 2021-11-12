import '../../objects/user.dart';

class Client extends User {
    String password;
    Client(String username, this.password, num user_id) : super(user_id, username)
}