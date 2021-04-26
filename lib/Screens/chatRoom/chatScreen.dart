import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/model/Chat.dart';
import 'components/chat_card.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: chatData.length,
            itemBuilder: (context, index) => ChatCard(
                chat: chatData[index],
                press: () {
                  Chat c = chatData[index];
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MessageScreen(details: c),
                    ),
                  );
                }),
          ),
        ),
      ],
    );
  }
}
