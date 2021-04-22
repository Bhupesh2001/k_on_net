import 'package:flutter/material.dart';
import 'package:flutter_autolink_text/flutter_autolink_text.dart';
import 'package:k_on_net/model/chat_message.dart';

import '../../../../constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.message,
  }) : super(key: key);
  final ChatMessage message;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20 * 0.75, vertical: 10),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(message.isSender
            ? (Theme.of(context).scaffoldBackgroundColor ==
                    kContentColorLightTheme
                ? 0.5
                : 1)
            : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: AutolinkText(
        text: message.text,
        textStyle: TextStyle(
            color: message.isSender
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1.color),
        linkStyle: TextStyle(color: Colors.blue),
        onWebLinkTap: (link) => print(link),
        onEmailTap: (link) => print(link),
        onPhoneTap: (link) => print(link),
      ),
    );
  }
}
