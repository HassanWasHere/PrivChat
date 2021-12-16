import '../../objects/user.dart';

/*
    This is the client object, it inherits from the user object as the client
    is still a user. The only difference is the client doesn't need a public key but
    needs a password instead to authenticate with the REST API when needed.
*/

class Client extends User {
    String username;
    String password;
    num user_id;
    Client(this.username, this.password, this.user_id) : super(user_id, username, "fornow");
}