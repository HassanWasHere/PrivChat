import 'package:socket_io_client/socket_io_client.dart' as websocket;
import '../handlers/config.dart';
import '../objects/client.dart';
class WebSocket {
    websocket.Socket? _sock;
    Client? thisUser;
    Function(String, WebSocket)? updateMessageCallback;
    WebSocket(Client thisUser, Function(String, WebSocket) callback){
        this.thisUser = thisUser;
        this.updateMessageCallback = callback;
        this._sock = websocket.io("$API_ENDPOINT_URL", websocket.OptionBuilder()
            .setTransports(['websocket'])
            .build()
        );
        if (this._sock != null && this.thisUser != null){
            this._sock?.onConnect((_){
                this._sock?.emit("auth", [this.thisUser!.username, this.thisUser!.password]);
            });
            this._sock?.on("conversation", (data){
                print("CONVO DATA RECIEVED " + data.toString());
                this.updateMessageCallback?.call(data.toString(), this);
            });
        };
        
    }

    websocket.Socket get_socket(){
        return this._sock!;
    }

}