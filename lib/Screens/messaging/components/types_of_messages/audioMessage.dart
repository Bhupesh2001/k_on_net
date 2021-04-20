import 'package:flutter/material.dart';
import 'package:k_on_net/model/chat_message.dart';

import '../../../../constants.dart';

class AudioMessage extends StatelessWidget {
  final ChatMessage message;

  const AudioMessage({Key key, this.message}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // height: 35,
      width: size.width * 0.5,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor.withOpacity(message.isSender ? 0.8 : 0.1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20 * 0.75, vertical: 20 / 2.5),
      child: Row(
        children: [
          Icon(
            Icons.play_arrow,
            color: message.isSender ? Colors.white : kPrimaryColor,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: (message.isSender ? Colors.white : kPrimaryColor)
                        .withOpacity(0.4),
                  ),
                  Positioned(
                    left: 0,
                    child: Container(
                      height: 8,
                      width: 8,
                      decoration: BoxDecoration(
                          color:
                              message.isSender ? Colors.white : kPrimaryColor,
                          shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Text(
            '3:14',
            style: TextStyle(
                fontSize: 12,
                color: message.isSender ? Colors.white : kPrimaryColor),
          )
        ],
      ),
    );
  }
}
