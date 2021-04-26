import 'package:flutter/material.dart';
import 'package:k_on_net/model/Chat.dart';
import 'components/messagingAppBar.dart';
import 'components/messagingBody.dart';

class MessageScreen extends StatefulWidget {
  static String id = 'MessageScreen';
  final Chat details;

  const MessageScreen({Key key, this.details}) : super(key: key);
  @override
  _MessageScreenState createState() => _MessageScreenState(details);
}

class _MessageScreenState extends State<MessageScreen> {
  final Chat details;

  _MessageScreenState(this.details);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: messagingAppBar(
        context: context,
        userName: details.name, // todo send the same of the user over here
        lastSeen: details.lastSeenTime, // todo send the last seen over here
        isActive: details.isActive, // todo send the online status here
      ),
      body: MessagingBody(),
    );
  }
}
