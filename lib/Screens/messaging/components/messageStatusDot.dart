import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/constants.dart';

class MessageStatusDot extends StatelessWidget {
  final DocumentSnapshot doc;

  const MessageStatusDot({Key key, this.doc}) : super(key: key);
  // Color dotColor(DocumentSnapshot doc) {
  //   switch (doc['']) {
  //     case MessageStatus.not_sent:
  //       return Colors.transparent;
  //       break;
  //     case MessageStatus.not_view:
  //       return kPrimaryColor;
  //       break;
  //     case MessageStatus.viewed:
  //       return kPrimaryColor;
  //       break;
  //     case MessageStatus.not_received:
  //       return kPrimaryColor;
  //       break;
  //     default:
  //       return Colors.transparent;
  //   }
  // }
  //
  // IconData statusIcon(DocumentSnapshot doc) {
  //   switch (doc['']) {
  //     case MessageStatus.viewed:
  //       return Icons.done;
  //       break;
  //     case MessageStatus.not_received:
  //       return Icons.access_time_outlined;
  //       break;
  //     default:
  //       return null;
  //       break;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    // bool
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 12,
      width: 12,
      // decoration: BoxDecoration(
      //   shape: BoxShape.circle,
      //   color: dotColor(doc),
      // ),
      // child: Icon(
      //   statusIcon(doc),
      //   size: 8,
      //   color: Colors.white,
      // ),
    );
  }
}
