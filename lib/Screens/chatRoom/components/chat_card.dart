import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/components/profileImage.dart';
import 'package:k_on_net/model/Chat.dart';

class ChatCard extends StatelessWidget {
  const ChatCard({
    Key key,
    @required this.chat,
    @required this.press,
  }) : super(key: key);
  final Chat chat;
  final VoidCallback press;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    var padding = 0.045;
    return InkWell(
      onTap: press,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: size.width * (padding - 0.008),
            vertical: size.width * padding),
        child: Row(
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'profileImage',
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2.0, bottom: 5),
                    child: ProfileImage(),
                  ),
                ),
                if (chat.isActive)
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: Container(
                      height: 16,
                      width: 16,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.greenAccent,
                        border: Border.all(
                            color: Theme.of(context).scaffoldBackgroundColor,
                            width: 1.8),
                      ),
                    ),
                  )
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: size.width * (padding - 0.008)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat.name,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: size.width * 0.012,
                    ),
                    Opacity(
                      opacity: 0.64,
                      child: Text(
                        chat.lastMessage,
                        style: TextStyle(fontSize: 15),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Opacity(opacity: 0.64, child: Text(chat.time))
          ],
        ),
      ),
    );
  }
}