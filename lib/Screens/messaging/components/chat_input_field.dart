import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';
import '../../../constants.dart';

class ChatInputField extends StatelessWidget {
  final doc;
  final String groupChatId;

  const ChatInputField(this.doc, this.groupChatId);

  sendText(String msg) async {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(SharedPreferencesHelper.myUid())
        .update({"isTyping": false});

    CollectionReference users = FirebaseFirestore.instance
        .collection('Messages')
        .doc(groupChatId)
        .collection(groupChatId);

    DocumentReference messageId = await users.add({
      "senderId": SharedPreferencesHelper.myUid(),
      "anotherUserId": doc['id'],
      "sendTime": DateTime.now(),
      'content': msg,
      "type": 'text',
      "seenTime": null,
      'received': false
    });
    messageId.update({"MessageId": messageId});
  }

  void typing(String value) async {
    DocumentReference myPath = FirebaseFirestore.instance
        .collection("Users")
        .doc(SharedPreferencesHelper.myUid());

    myPath.update({"isTyping": true}).then((value) async =>
        await Future.delayed(Duration(seconds: 4))
            .then((value) => myPath.update({"isTyping": false})));
  }

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
                            typing, // Its is called when an alphabet is added or removed from TextField
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
                if (tecMessage.text.trim().isNotEmpty) {
                  sendText(tecMessage.text);
                  tecMessage.clear();
                }
                if (!FocusScope.of(context).hasPrimaryFocus)
                  FocusScope.of(context).unfocus();
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
