import 'package:flutter/material.dart';
import 'package:k_on_net/model/chat_message.dart';
import '../../../../constants.dart';

class AudioMessage extends StatefulWidget {
  final ChatMessage message;

  const AudioMessage({Key key, this.message}) : super(key: key);
  @override
  _AudioMessageState createState() => _AudioMessageState(message);
}

class _AudioMessageState extends State<AudioMessage> {
  final ChatMessage message;

  _AudioMessageState(this.message);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool played = false;
    return Container(
      // height: 35,
      width: size.width * 0.40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor.withOpacity(this.message.isSender ? 0.8 : 0.1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20 * 0.75, vertical: 20 / 8),
      child: Row(
        children: [
          InkWell(
            child: Icon(
              Icons.play_arrow,
              size: 18,
              color: message.isSender ? Colors.white : kPrimaryColor,
            ),
            onTap: () {
              print('Playing audio');
              setState(() {
                played = true;
              });
            },
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Stack(
                clipBehavior: Clip.none,
                alignment:
                    played ? Alignment.centerRight : Alignment.centerLeft,
                children: [
                  Container(
                    width: double.infinity,
                    height: 2,
                    color: (message.isSender ? Colors.white : kPrimaryColor)
                        .withOpacity(0.4),
                  ),
                  Positioned(
                    // left: size.width * 0.19,
                    child: AnimatedContainer(
                      duration: Duration(seconds: 50),
                      height: 6,
                      width: 6,
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
                fontSize: 10,
                color: message.isSender ? Colors.white : kPrimaryColor),
          )
        ],
      ),
    );
  }
}
