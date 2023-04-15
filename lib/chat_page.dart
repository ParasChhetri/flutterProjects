import 'package:chat_app_pr/messages_view.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  TextEditingController msgInputController = TextEditingController();
  late IO.Socket socket;
  // final IO.Socket _scoket = IO.io('http://localhost:3000');

  // _connectSocket() {
  //   _scoket.onConnect((data) => print('connected'));
  //   _scoket.onConnectError((data) => print('Connectio error: $data'));
  //   _scoket.onDisconnect((data) => print('Socket.IO server disconnected'));
  // }

  @override
  // void initState() {
  //   super.initState();
  //   _connectSocket();
  // }
  void initState() {
    socket = IO.io(
        'http://localhost:4000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    setUpSocketListner();
    super.initState();
  }

  void sentMessage(String text) {
    var messageJson = {
      "message": text,
      "sentMsg": socket.id,
    };
    socket.emit("message", messageJson);
  }

  void setUpSocketListner() {
    socket.on('message-receive', (data) {
      print(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade400,
        body: Container(
          child: Column(
            children: [
              Expanded(
                flex: 9,
                child: Container(
                  child: ListView.builder(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return MessageItem(
                        sentMsg: true,
                      );
                    },
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: TextField(
                    cursorColor: Colors.purple,
                    controller: msgInputController,
                    decoration: InputDecoration(
                      hintText: "Write your message",
                      hintStyle: const TextStyle(color: Colors.white),
                      border: InputBorder.none,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      suffixIcon: Container(
                        child: IconButton(
                          onPressed: () {
                            sentMessage(msgInputController.text);
                            msgInputController.text = "";
                          },
                          icon: const Icon(
                            Icons.send,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
