import 'package:flutter/material.dart';

import 'components/messagingAppBar.dart';
import 'components/messagingBody.dart';

class MessageScreen extends StatefulWidget {
  static String id = 'MessageScreen';
  final doc;

  const MessageScreen(this.doc);

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: messagingAppBar(
          context: context,
          doc: widget.doc,
        ),
        body: MessagingBody(widget.doc),
      ),
    );
  }
}
