import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoomMain.dart';
import 'package:k_on_net/components/profileImage.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/services/Firestore.dart';

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
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection("Users")
            .where('phone', whereIn: number)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null)
            return ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) => ListTile(
                leading: ProfileImage(edgeLength: 35),
                onTap: () {
                  close(context, null);
                  //TODO Anmol yaha kam kar
                  FireStoreHelper.createRoom(snapshot.data.docs[index]);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            MessageScreen(snapshot.data.docs[index])),
                  );
                },
                title: Text(names[
                    number.indexOf((snapshot.data.docs[index])['phone'])]),
                subtitle: Text((snapshot.data.docs[index])['phone']),
              ),
            );
          else
            return Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                color: kSecondaryColor);
        });
  }
}
