// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// sendMsg(
//   String message,
// ) {
//   String msg = message;
//
//   /// Upload images to firebase and returns a URL
//   if (msg.isNotEmpty) {
//     print('this is called $msg');
//     var ref = FirebaseFirestore.instance
//         .collection('messages')
//         .doc(groupChatId)
//         .collection(groupChatId)
//         .document(DateTime.now().millisecondsSinceEpoch.toString());
//
//     FirebaseFirestore.instance.runTransaction((transaction) async {
//       await transaction.set(ref, {
//         "senderId": userID,
//         "anotherUserId": widget.docs['id'],
//         "timestamp": DateTime.now().millisecondsSinceEpoch.toString(),
//         'content': msg,
//         "type": 'text',
//       });
//     });
//
//     scrollController.animateTo(0.0,
//         duration: Duration(milliseconds: 100), curve: Curves.bounceInOut);
//   } else {
//     print('Please enter some text to send');
//   }
// }
