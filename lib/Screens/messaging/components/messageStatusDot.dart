import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/constants.dart';

class MessageStatusDot extends StatelessWidget {
  final DocumentSnapshot doc;

  const MessageStatusDot({Key key, this.doc}) : super(key: key);
  Color dotColor(DocumentSnapshot doc) {
    if (doc['received'] ?? false) return kPrimaryColor;
    return kPrimaryColor;
  }

  IconData statusIcon(DocumentSnapshot doc) {
    if (doc['received'] ?? false) return Icons.done;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // bool
    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dotColor(doc),
      ),
      child: Icon(
        statusIcon(doc),
        size: 8,
        color: Colors.white,
      ),
    );
  }
}
