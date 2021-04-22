import 'package:flutter/material.dart';
import '../../../constants.dart';

class ChatInputField extends StatelessWidget {
  const ChatInputField({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController tecMessage = new TextEditingController();
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
            InkWell(
              onTap: () {},
              child: Icon(
                Icons.mic,
                color: kPrimaryColor,
              ),
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
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        onChanged:
                            null, // Its is called when an alphabet is added or removed from TextField
                        controller: tecMessage,
                        decoration: InputDecoration(
                          hintText: "Type message",
                          border: InputBorder.none,
                        ),
                        cursorColor: kPrimaryColor,
                      ),
                    ),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.attach_file,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.64),
                      ),
                    ),
                    SizedBox(width: 5),
                    InkWell(
                      onTap: () {},
                      child: Icon(
                        Icons.camera_alt_outlined,
                        color: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .color
                            .withOpacity(0.64),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(width: 10),
            InkWell(
              onTap: () {
                print(tecMessage.text);
              },
              child: Icon(
                Icons.send,
                size: 30,
                color: kPrimaryColor,
              ),
            )
          ],
        ),
      ),
    );
  }
}
