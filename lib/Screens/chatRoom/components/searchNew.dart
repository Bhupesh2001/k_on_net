import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoomMain.dart';
import 'package:k_on_net/components/profileImage.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/services/Firestore.dart';
import 'package:k_on_net/utility/contacts.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

class SearchNew extends SearchDelegate<String> {
  void getNumbers() async {
    List<String> contactNumbers = [];
    List<String> contactNames = [];
    Iterable<Contact> _contacts =
        await ContactsService.getContacts(withThumbnails: false);

    _contacts.forEach((contact) {
      contact.phones.toSet().forEach((phone) {
        contactNames.add(contact.displayName ?? contact.givenName);
        contactNumbers.add(phone.value
            .replaceFirst('+91', '')
            .replaceFirst(' ', '')
            .replaceFirst('(', '')
            .replaceFirst(')', '')
            .replaceFirst('-', ''));
      });
    });
    ContactUtils.phoneNum = contactNumbers.toSet().toList();
    ContactUtils.phoneNames = contactNames.toSet().toList();
  }

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
    getNumbers();
    return SingleChildScrollView(
      child: Column(
        children: [
          for (int i = 0; i < ContactUtils.phoneNum.length; i++)
            FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection("Users")
                  .where('phone', isEqualTo: ContactUtils.phoneNum[i])
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data.size > 0) {
                  return ListTile(
                    leading: ProfileImage(edgeLength: 35),
                    onTap: () {
                      close(context, null);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                MessageScreen(snapshot.data.docs[0])),
                      );
                      onTap(snapshot);
                    },
                    title: Text((snapshot.data.docs[0])['name']),
                    subtitle: Text(
                      ContactUtils.phoneNum[i],
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                } else
                  return SizedBox.shrink();
              },
            ),
        ],
      ),
    );
  }

  onTap(AsyncSnapshot<QuerySnapshot<Object>> snapshot) {
    FirebaseFirestore.instance
        .collection("Users")
        .doc(SharedPrefHelper.myUid())
        .update({
      'friends': FieldValue.arrayUnion([(snapshot.data.docs[0])['id']])
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
        .collection(FireStoreHelper.getGroupChatId(snapshot.data.docs[0]))
        .doc('lastMessages')
        .set({
      'message': null,
      'time': null,
      'sender': SharedPrefHelper.myUid()
    });
  }
}
