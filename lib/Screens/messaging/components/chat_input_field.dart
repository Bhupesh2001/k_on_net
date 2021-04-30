import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';
import '../../../constants.dart';

class ChatInputField extends StatelessWidget {
  final doc;
  final String groupChatId;

  const ChatInputField(this.doc, this.groupChatId);

  sendMsg(String msg) {
    print("sendMsgStarted");

    /// Upload images to firebase and returns a URL
    if (msg.length > 0) {
      print('this is called $msg');
      var ref = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(ref, {
          "senderId": SharedPreferencesHelper.myUid(),
          "anotherUserId": doc['id'],
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          'content': msg,
          "type": 'text',
        });
      });

      // scrollController.animateTo(0.0,
      //     duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
    } else {
      print('Please enter some text to send');
    }
  }

  sendText(String msg) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('Messages')
        .doc(groupChatId)
        .collection(groupChatId);

    print(groupChatId);

    users.add({
      "senderId": SharedPreferencesHelper.myUid(),
      "anotherUserId": doc['id'],
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      'content': msg,
      "type": 'text',
    });
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
                if (tecMessage.text.trim().isNotEmpty)
                  sendText(tecMessage.text);
                tecMessage.clear();
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
