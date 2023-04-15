import 'package:flutter/material.dart';

class MessageItem extends StatefulWidget {
  final bool sentMsg;
  final String? message;
  const MessageItem({super.key, required this.sentMsg,this.message});

  @override
  State<MessageItem> createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  bool sentMsg = true;
  // void controll() {
  //   setState(() {
  //     sentMsg = !sentMsg;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: sentMsg ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        decoration: BoxDecoration(
          color: sentMsg ? Colors.greenAccent : Colors.blue,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Yo',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              '07:00 AM',
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }
}