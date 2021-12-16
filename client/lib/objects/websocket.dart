import 'package:socket_io_client/socket_io_client.dart' as websocket;
import '../handlers/config.dart';
import '../objects/client.dart';
/*
    This class represents a WebSocket client which will connect to the
    WebSocket on the server.
*/
class WebSocket {
    /*
        The _sock object represents a Socket object provided by the socket_io_client package.
        This WebSocket class is a wrapper around this object.
        This class also needs a 'updateMessageCallback' attribute.
        This attribute is the function that will be called when the server sends
        'conversation' and the message data across the socket. This is an asynchonrous
        callback and is defined in the conversation list page.
    */
    websocket.Socket? _sock;
    Client? thisUser;
    Function(String, WebSocket)? updateMessageCallback;
    WebSocket(Client thisUser, Function(String, WebSocket) callback){
        this.thisUser = thisUser;
        this.updateMessageCallback = callback;
        /*
            This attempts to connect to the Websocket by creating the Socket object using the io function from the WebSocket module.
        */
        this._sock = websocket.io("$API_ENDPOINT_URL", websocket.OptionBuilder()
            .setTransports(['websocket']) // We want to use the WebSocket protocol for sockets.
            .build()
        );
        if (this._sock != null && this.thisUser != null){
            this._sock?.onConnect((_){  // Try authenticate as soon as we have connected
                this._sock?.emit("auth", [this.thisUser!.username, this.thisUser!.password]);
            });
            this._sock?.on("conversation", (data){
                //When we recieve conversation data, call the update callback so it is displayed.
                this.updateMessageCallback?.call(data.toString(), this);
            });
        };
        
    }
    // Getter returns the Socket object from the module
    websocket.Socket get_socket(){
        return this._sock!;
    }

}