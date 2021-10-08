import 'package:flutter/material.dart';
class MessageListPage extends StatefulWidget {
    MessageListPage({Key? key}) : super(key: key);

    String Response = '';

    void setResponseData(String data){
        Response = data;
    }

    @override
    _MessageListPageWithState createState() =>  _MessageListPageWithState();
}


class _MessageListPageWithState extends State<MessageListPage> {

    Widget build(BuildContext ctx){
        return Scaffold(
            body: Text(widget.Response)
        );
    }
}