import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/components/profileImage.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';
import 'messageStatusDot.dart';
import 'types_of_messages/audioMessage.dart';
import 'types_of_messages/text_message.dart';
import 'types_of_messages/videoMessage.dart';

class Message extends StatelessWidget {
  final doc;

  const Message(this.doc);

  @override
  Widget build(BuildContext context) {
    bool isSender() => doc['senderId'] == SharedPrefHelper.myUid();
    if (!isSender()) {
      Future.delayed(Duration(milliseconds: 100), () {
        doc['MessageId'].update({'received': true});
      });
    }
    return Padding(
      padding: isSender()
          ? EdgeInsets.only(top: 10, right: 10)
          : EdgeInsets.only(top: 10, left: 3),
      child: Column(
        crossAxisAlignment:
            isSender() ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isSender() ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              SizedBox(width: 10),
              if (!isSender()) ProfileImage(edgeLength: 25),
              SizedBox(width: 10),
              messageContent(doc),
              if (isSender()) MessageStatusDot(doc: doc),
            ],
          ),
          Padding(
            padding: isSender()
                ? EdgeInsets.only(right: 29, top: 1)
                : EdgeInsets.only(left: 45, top: 1),
            child: Opacity(
              opacity: 0.5,
              child: Text(
                // timeInHourMinFormat(doc['sendTime']),
                timeInAgoFormat(doc['sendTime']),
                style: TextStyle(fontSize: 10, wordSpacing: 2),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget messageContent(DocumentSnapshot doc) {
  switch (doc['type']) {
    case 'text':
      return TextMessage(doc: doc);
      break;
    case 'audio':
      return AudioMessage();
      break;
    case 'video':
      return VideoMessage();
      break;
    default:
      return SizedBox();
  }
}
