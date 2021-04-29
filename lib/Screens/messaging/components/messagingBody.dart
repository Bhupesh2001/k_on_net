// import 'package:flutter/material.dart';
// import 'package:k_on_net/model/chat_message.dart';
// import 'message.dart';
//
// class MessagingBody extends StatefulWidget {
//   @override
//   _MessagingBodyState createState() => _MessagingBodyState();
// }
//
// class _MessagingBodyState extends State<MessagingBody> {
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: ListView.builder(
//               itemCount: demoChatMessage.length,
//               itemBuilder: (context, index) =>
//                   Message(message: demoChatMessage[index]),
//             ),
//           ),
//         ),
//         ChatInputField(),
//       ],
//     );
//   }
// }
///////////////////////////////////////////////////////////////////////
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'chat_input_field.dart';

class MessagingBody extends StatefulWidget {
  final docs;

  const MessagingBody(this.docs);

  @override
  _MessagingBodyState createState() => _MessagingBodyState();
}

class _MessagingBodyState extends State<MessagingBody> {
  String groupChatId;
  String userID;

  TextEditingController textEditingController = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    getGroupChatId();
    createRecord();
    super.initState();
  }

  getGroupChatId() async {
    print("getGroupChatIdStarted");
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    userID = sharedPreferences.getString('id');

    // String anotherUserId = "WZlXknr664SFivA3gkOf";
    String anotherUserId = widget.docs['id'];

    if (userID.compareTo(anotherUserId) > 0) {
      groupChatId = '$userID - $anotherUserId';
    } else {
      groupChatId = '$anotherUserId - $userID';
    }
    print("getGroupChatIdEnded");
  }

  void createRecord() async {
    print("createRecordStarted");
    await FirebaseFirestore.instance
        .collection("books")
        .doc(groupChatId)
        .collection(groupChatId)
        .doc()
        .set({
      "senderId": '',
      "anotherUserId": '',
      "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
      'content': 'msg',
      "type": 'text',
    });
    setState(() {});
    print("createRecordEnd");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('Messages').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: <Widget>[
                Expanded(
                    child: ListView.builder(
                  controller: scrollController,
                  itemBuilder: (listContext, index) =>
                      buildItem(snapshot.data.docs[index]),
                  itemCount: snapshot.data.docs.length,
                  reverse: true,
                )),
                ChatInputField(widget.docs, groupChatId),
              ],
            );
          } else {
            return Center(
                child: SizedBox(
              height: 36,
              width: 36,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              ),
            ));
          }
        },
      ),
    );
  }

  sendMsg() {
    print("sendMsgStarted");
    String msg = textEditingController.text.trim();

    /// Upload images to firebase and returns a URL
    if (msg.isNotEmpty) {
      print('this is called $msg');
      var ref = FirebaseFirestore.instance
          .collection('messages')
          .doc(groupChatId)
          .collection(groupChatId)
          .doc(DateTime.now().millisecondsSinceEpoch.toString());

      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(ref, {
          "senderId": userID,
          "anotherUserId": widget.docs['id'],
          "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
          'content': msg,
          "type": 'text',
        });
      });

      scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
    } else {
      print('Please enter some text to send');
    }
  }

  buildItem(doc) {
    return Padding(
      padding: EdgeInsets.only(
          top: 8.0,
          left: ((doc['senderId'] == userID) ? 64 : 0),
          right: ((doc['senderId'] == userID) ? 0 : 64)),
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: ((doc['senderId'] == userID)
                ? Colors.grey
                : Colors.greenAccent),
            borderRadius: BorderRadius.circular(8.0)),
        child: (doc['type'] == 'text')
            ? Text('${doc['content']}')
            : Image.network(doc['content']),
      ),
    );
  }
}
