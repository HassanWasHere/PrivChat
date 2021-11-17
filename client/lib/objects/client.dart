import '../../objects/user.dart';

class Client extends User {
    String username;
    String password;
    num user_id;
    Client(this.username, this.password, this.user_id) : super(user_id, username, "fornow");
}