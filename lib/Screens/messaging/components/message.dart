import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/components/profileImage.dart';
import 'file:///D:/K%20On%20Net%20OFFICIAL/k_on_net/lib/Screens/messaging/components/types_of_messages/text_message.dart';
import 'package:k_on_net/model/chat_message.dart';
import 'messageStatusDot.dart';
import 'types_of_messages/audioMessage.dart';
import 'types_of_messages/videoMessage.dart';

class Message extends StatefulWidget {
  final ChatMessage message;

  const Message({Key key, this.message}) : super(key: key);
  @override
  _MessageState createState() => _MessageState(message);
}

class _MessageState extends State<Message> {
  final ChatMessage message;

  _MessageState(this.message);
  @override
  Widget build(BuildContext context) {
    Widget messageContent(ChatMessage message) {
      switch (message.messageType) {
        case ChatMessageType.text:
          return TextMessage(message: message);
          break;
        case ChatMessageType.audio:
          return AudioMessage(message: message);
          break;
        case ChatMessageType.video:
          return VideoMessage();
          break;
        default:
          return SizedBox();
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: message.isSender
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: message.isSender
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
            children: [
              if (!message.isSender) ProfileImage(edgeLength: 23),
              SizedBox(width: 10),
              messageContent(message),
              if (message.isSender)
                MessageStatusDot(
                  status: message.messageStatus,
                ),
            ],
          ),
          Padding(
            padding: message.isSender
                ? EdgeInsets.only(right: 29, top: 1)
                : EdgeInsets.only(left: 45, top: 1),
            child: Opacity(
              opacity: 0.5,
              child: Text(
                message.sendTime,
                style: TextStyle(fontSize: 9),
              ),
            ),
          )
        ],
      ),
    );
  }
}
