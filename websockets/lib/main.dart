import 'package:flutter/material.dart';
import 'package:web_socket_channel/html.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(
        channel: HtmlWebSocketChannel.connect("ws://echo.websocket.events"),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  final WebSocketChannel channel;
  const HomePage({super.key, required this.channel});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Websockets in Actions")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Form(
              child: TextFormField(
                onChanged: _sendMyMessageOnRunTime,
                controller: _controller,
                decoration: InputDecoration(label: Text("Send any message")),
              ),
            ),
            StreamBuilder(
              stream: widget.channel.stream,
              builder: (context, snapsot) {
                return Padding(
                  padding: EdgeInsets.all(8),
                  child: Text(snapsot.hasData ? snapsot.data : ""),
                );
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMyMessage,
        child: Icon(Icons.send),
      ),
    );
  }

  void _sendMyMessage() {
    if (_controller.text.isNotEmpty) {
      widget.channel.sink.add(_controller.text);
    }
  }

  @override
  void dispose() {
    widget.channel.sink.close();
    super.dispose();
  }

  void _sendMyMessageOnRunTime(String value) {
    if(value.isNotEmpty){
      widget.channel.sink.add(value);
    }
  }
}
