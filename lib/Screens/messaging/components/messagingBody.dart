import 'package:flutter/material.dart';
import 'package:k_on_net/model/chat_message.dart';
import 'chat_input_field.dart';
import 'message.dart';

class MessagingBody extends StatefulWidget {
  @override
  _MessagingBodyState createState() => _MessagingBodyState();
}

class _MessagingBodyState extends State<MessagingBody> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView.builder(
              reverse: true,
              itemCount: demoChatMessage.length,
              itemBuilder: (context, index) =>
                  Message(message: demoChatMessage[index]),
            ),
          ),
        ),
        ChatInputField(),
      ],
    );
  }
}
