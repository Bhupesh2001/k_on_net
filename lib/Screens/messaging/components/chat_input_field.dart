import 'package:flutter/material.dart';
import '../../../constants.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: Offset(0, 4),
            blurRadius: 32,
            color: kPrimaryColor.withOpacity(0.08))
      ], color: Theme.of(context).scaffoldBackgroundColor),
      child: SafeArea(
        child: Row(
          children: [
            Icon(
              Icons.mic,
              color: kPrimaryColor,
            ),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20 * 0.75),
                decoration: BoxDecoration(
                  color: kPrimaryColor.withOpacity(0.05),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.sentiment_satisfied_alt,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Icon(
                      Icons.attach_file,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.camera_alt_outlined,
                      color: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .color
                          .withOpacity(0.64),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.send,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
