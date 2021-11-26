import 'package:socket_io_client/socket_io_client.dart' as websocket;
import '../handlers/config.dart';
import '../objects/client.dart';
class WebSocket {
    websocket.Socket? sock;
    Client? thisUser;
    WebSocket(Client thisUser){
        this.thisUser = thisUser;
        try {
            this.sock = websocket.io("$API_ENDPOINT_URL", websocket.OptionBuilder()
                .setTransports(['websocket'])
                .build()
            );
            this.sock?.onConnect((_){
                this.sock?.emit("conversations", [this.thisUser?.username, this.thisUser?.password]);
            });
            this.sock?.on("conversation", (data){
                print("WEBSOCK" + data.toString());
            });
        } catch (e){
            print(e);
        }
    }

}