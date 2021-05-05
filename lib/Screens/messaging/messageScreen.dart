import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/services/Firestore.dart';
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
  void initState() {
    super.initState();
    FireStoreHelper.lastSeenOnlineUpdate(widget.doc);
    // try {
    //   DocumentReference path = widget.doc['MessageId'];
    //   path.update({'seenTime': DateTime.now()});
    // } catch (e) {
    //   print(e.toString());
    // }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: messagingAppBar(context: context, doc: widget.doc),
        body: MessagingBody(widget.doc),
      ),
    );
  }
}
