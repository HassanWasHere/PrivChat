import 'package:socket_io_client/socket_io_client.dart' as websocket;
import '../handlers/config.dart';
class WebSocket {
    websocket.Socket? sock;
    WebSocket(){
        try {
            this.sock = websocket.io("$API_ENDPOINT_URL:$WEBSOCKET_PORT", websocket.OptionBuilder()
                .setTransports(['websocket']) // for Flutter or Dart VM
                .build()
            );
            this.sock?.onConnect((_){
                print("WEBSOCKET CONNECTION ESTABLISED");
            });
        } catch (e){
            print(e);
        }
    }

}