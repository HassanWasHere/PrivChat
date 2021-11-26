import 'package:socket_io_client/socket_io_client.dart' as websocket;
import '../handlers/config.dart';
import '../objects/client.dart';
class WebSocket {
    websocket.Socket? sock;
    Client? thisUser;
    Function(String)? updateMessageCallback;
    WebSocket(Client thisUser, Function(String) callback){
        this.thisUser = thisUser;
        this.updateMessageCallback = callback;
        try {
            this.sock = websocket.io("$API_ENDPOINT_URL", websocket.OptionBuilder()
                .setTransports(['websocket'])
                .build()
            );
            this.sock?.onConnect((_){
                this.sock?.emit("conversations", [this.thisUser?.username, this.thisUser?.password]);
            });
            this.sock?.on("conversation", (data){
                this.updateMessageCallback?.call(data.toString());
            });
        } catch (e){
            print(e);
        }
    }

}