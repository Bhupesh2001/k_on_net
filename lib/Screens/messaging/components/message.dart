import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/components/profileImage.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/model/chat_message.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

import 'file:///D:/K%20On%20Net%20OFFICIAL/k_on_net/lib/Screens/messaging/components/types_of_messages/text_message.dart';

import 'types_of_messages/audioMessage.dart';
import 'types_of_messages/videoMessage.dart';

class Message extends StatelessWidget {
  final doc;

  const Message(this.doc);

  @override
  Widget build(BuildContext context) {
    Widget messageContent(ChatMessage message) {
      switch (doc['type']) {
        case 'text':
          return TextMessage(message: message);
          break;
        case 'audio':
          return AudioMessage(message: message);
          break;
        case 'video':
          return VideoMessage();
          break;
        default:
          return SizedBox();
      }
    }

    bool isSender() => doc['senderId'] == SharedPreferencesHelper.myUid();
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment:
            isSender() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isSender() ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              if (!isSender()) ProfileImage(edgeLength: 23),
              SizedBox(width: 10),
              messageContent(doc['content']),
              // if (isSender()) MessageStatusDot(status: message.messageStatus),
            ],
          ),
          Padding(
            padding: isSender()
                ? EdgeInsets.only(right: 29, top: 1)
                : EdgeInsets.only(left: 45, top: 1),
            child: Opacity(
              opacity: 0.5,
              child: Text(
                doc['timestamp'],
                style: TextStyle(fontSize: 9),
              ),
            ),
          )
        ],
      ),
    );
  }
}

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
