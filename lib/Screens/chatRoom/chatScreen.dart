import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/chatRoom/components/chat_card.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userId;

  @override
  void initState() {
    getUserId();
    Firebase.initializeApp();
    super.initState();
  }

  getUserId() async {
    userId = SharedPreferencesHelper.myUid();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection("Users")
          .where("id", isNotEqualTo: userId)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          return ListView.builder(
            itemBuilder: (listContext, index) =>
                ChatCard(snapshot.data.docs[index]),
            itemCount: snapshot.data.docs.length,
          );
        }
        return Container(child: CircularProgressIndicator());
      },
    ));
  }

  buildItem(doc) {
    return (userId != doc['id'])
        ? GestureDetector(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => MessageScreen(doc)));
            },
            child: Card(
              color: Colors.lightBlue,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Center(
                    child: Text(doc['name']),
                    // child: Text(doc['name']),
                  ),
                ),
              ),
            ),
          )
        : Container(color: Colors.green);
  }
}
