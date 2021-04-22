import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoomMain.dart';
import 'package:k_on_net/Screens/components/profileImage.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/model/Chat.dart';

class SearchData extends SearchDelegate<String> {
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
    Chat c;
    List<String> names = [];
    for (int i = 0; i < chatData.length; i++) {
      c = chatData[i];
      names.add(c.name);
    }
    final suggestionList = query.isEmpty
        ? names
        : names
            .where((element) =>
                element.toUpperCase().startsWith(query.toUpperCase()))
            .toList();
    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) => ListTile(
        leading: ProfileImage(edgeLength: 35),
        onTap: () {
          close(context, null);
          Navigator.pushNamed(context, MessageScreen.id);
        },
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].substring(0, query.length),
            style: TextStyle(
                color: Theme.of(context).textTheme.bodyText1.color,
                fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: suggestionList[index].substring(query.length),
                style: TextStyle(
                    color: Theme.of(context).textTheme.bodyText1.color,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
