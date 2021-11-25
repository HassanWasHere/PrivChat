def create_socket_routes(socketio):
    @socketio.on('message')
    def handle_message(data):
        print('received message: ' + data)