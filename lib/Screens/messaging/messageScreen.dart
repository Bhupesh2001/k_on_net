import 'package:flutter/material.dart';
import 'components/messagingAppBar.dart';
import 'components/messagingBody.dart';

class MessageScreen extends StatefulWidget {
  static String id = 'MessageScreen';
  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: messagingAppBar(
        context: context,
        userName: 'Bhupesh', // todo send the same of the user over here
        lastSeen: '2 min ago', // todo send the last seen over here
        isActive: true, // todo send the online status here
      ),
      body: MessagingBody(),
    );
  }
}
