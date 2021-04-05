import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/components/background.dart';
import 'package:k_on_net/constants.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  @override
  Widget build(BuildContext context) {
    return Background(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: Text(
            'K-On-Net',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        body: Background(
          child: Container(),
        ),
      ),
    );
  }
}
