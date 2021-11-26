def create_socket_routes(socketio):
    @socketio.on('auth')
    def handle_message(data):
        print('received message: ' + data)