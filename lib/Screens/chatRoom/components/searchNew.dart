import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoomMain.dart';
import 'package:k_on_net/components/profileImage.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/services/Firestore.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

class SearchNew extends SearchDelegate<String> {
  final List<String> number;
  final List<String> names;

  SearchNew(this.number, this.names);
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: transitionAnimation,
          ),
          onPressed: () {
            if (query.isEmpty)
              close(context, null);
            else
              query = "";
          })
    ];
  }

  @override
  ThemeData appBarTheme(BuildContext context) {
    Color iconColor =
        Theme.of(context).scaffoldBackgroundColor == kContentColorLightTheme
            ? Colors.white
            : kPrimaryColor;
    return Theme.of(context).copyWith(
        appBarTheme: AppBarTheme(
          color: Theme.of(context).scaffoldBackgroundColor,
          actionsIconTheme: IconThemeData(color: iconColor),
          iconTheme: IconThemeData(color: iconColor),
        ),
        hintColor:
            Theme.of(context).scaffoldBackgroundColor == kContentColorLightTheme
                ? Colors.white54
                : Colors.black54);
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.ellipsis_search,
          progress: transitionAnimation,
        ),
        onPressed: () {});
  }

  @override
  Widget buildResults(BuildContext context) {
    close(context, null);
    return ChatRoomMain();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ListView.builder(
      itemCount: number.length,
      itemBuilder: (context, index) => StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where('phone', isEqualTo: number[index])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data.size == 1) {
            return ListTile(
              leading: ProfileImage(edgeLength: 35),
              onTap: () {
                close(context, null);
                print((snapshot.data.docs[0])['id']);
                print(SharedPrefHelper.myUid());
                // FireStoreHelper.createRoom(snapshot.data.docs[0]);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          MessageScreen(snapshot.data.docs[0])),
                );
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc(SharedPrefHelper.myUid())
                    .update({
                  'friends':
                      FieldValue.arrayUnion([(snapshot.data.docs[0])['id']])
                });
                FirebaseFirestore.instance
                    .collection("Users")
                    .doc((snapshot.data.docs[0])['id'])
                    .update({
                  'friends': FieldValue.arrayUnion([SharedPrefHelper.myUid()])
                });
                FirebaseFirestore.instance
                    .collection('Messages')
                    .doc(FireStoreHelper.getGroupChatId(snapshot.data.docs[0]))
                    .collection(
                        FireStoreHelper.getGroupChatId(snapshot.data.docs[0]))
                    .doc('lastMessages')
                    .set({
                  'message': null,
                  'time': null,
                  'sender': SharedPrefHelper.myUid()
                });
              },
              title: Text(names[index]),
              subtitle: Text(number[index]),
            );
          } else
            return Container(width: 0.0, height: 0.0);
        },
      ),
    );
  }
}
