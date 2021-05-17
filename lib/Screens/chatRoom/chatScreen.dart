import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/chatRoom/components/chat_card.dart';
import 'package:k_on_net/components/loadingIndicator.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  String userId = SharedPrefHelper.myUid();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where("friends", arrayContains: SharedPrefHelper.myUid())
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              itemBuilder: (listContext, index) =>
                  ChatCard(snapshot.data.docs[index]),
              itemCount: snapshot.data.docs.length,
            );
          } else
            return LoadingIndicator(isLoading: true);
        },
      ),
    );
  }
}
