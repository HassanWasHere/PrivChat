import 'package:socket_io_client/socket_io_client.dart';
import '../handlers/config.dart';
class WebSocket {
    Socket socket;
    WebSocket(){
        this.socket = io("$API_ENDPOINT_URL:$WEBSOCKET_PORT");

    }

    Future<void> sendMessage()

}