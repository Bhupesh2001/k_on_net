import 'package:flutter/material.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/model/chat_message.dart';

class MessageStatusDot extends StatelessWidget {
  final MessageStatus status;

  const MessageStatusDot({Key key, this.status}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Color dotColor(MessageStatus status) {
      switch (status) {
        case MessageStatus.not_sent:
          return Colors.transparent;
          break;
        case MessageStatus.not_view:
          return kPrimaryColor;
          break;
        case MessageStatus.viewed:
          return kPrimaryColor;
          break;
        case MessageStatus.not_received:
          return kPrimaryColor;
          break;
        default:
          return Colors.transparent;
      }
    }

    IconData statusIcon(MessageStatus status) {
      switch (status) {
        case MessageStatus.viewed:
          return Icons.done;
          break;
        case MessageStatus.not_received:
          return Icons.access_time_outlined;
          break;
        default:
          return null;
          break;
      }
    }

    return Container(
      margin: EdgeInsets.only(left: 10),
      height: 12,
      width: 12,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: dotColor(status),
      ),
      child: Icon(
        statusIcon(status),
        size: 8,
        color: Colors.white,
      ),
    );
  }
}
