import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/messaging/components/message.dart';
import 'package:k_on_net/components/loadingIndicator.dart';
import 'package:k_on_net/services/Firestore.dart';
import 'chat_input_field.dart';

class MessagingBody extends StatefulWidget {
  final DocumentSnapshot docs;

  const MessagingBody(this.docs);

  @override
  _MessagingBodyState createState() => _MessagingBodyState();
}

class _MessagingBodyState extends State<MessagingBody> {
  String userID;

  TextEditingController textEditingController = TextEditingController();

  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    String groupChatId = FireStoreHelper.getGroupChatId(widget.docs);
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('Messages')
            .doc(groupChatId)
            .collection(groupChatId)
            .orderBy('sendTime', descending: false)
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return Column(
              children: <Widget>[
                Expanded(
                  child: ListView.builder(
                    controller: scrollController,
                    itemBuilder: (listContext, index) =>
                        Message(snapshot.data.docs[index]),
                    itemCount: snapshot.data.docs.length,
                    // reverse: true,
                  ),
                ),
                ChatInputField(
                    widget.docs, FireStoreHelper.getGroupChatId(widget.docs)),
              ],
            );
          } else {
            return Center(
              child: SizedBox(
                height: 36,
                width: 36,
                child: LoadingIndicator(isLoading: true),
              ),
            );
          }
        },
      ),
    );
  }
}
