import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';
import '../../../../constants.dart';

class TextMessage extends StatelessWidget {
  const TextMessage({
    Key key,
    this.doc,
  }) : super(key: key);
  final DocumentSnapshot doc;
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minWidth: 5,
        maxWidth: MediaQuery.of(context).size.width * 0.65,
        maxHeight: MediaQuery.of(context).size.width * 0.8,
      ),
      padding: EdgeInsets.symmetric(horizontal: 20 * 0.75, vertical: 10),
      decoration: BoxDecoration(
        color: kPrimaryColor.withOpacity(
            doc['senderId'] == SharedPrefHelper.myUid()
                ? (Theme.of(context).scaffoldBackgroundColor ==
                        kContentColorLightTheme
                    ? 0.5
                    : 1)
                : 0.1),
        borderRadius: BorderRadius.circular(30),
      ),
      child: SelectableText(
        doc['content'],
        style: TextStyle(
            color: doc['senderId'] == SharedPrefHelper.myUid()
                ? Colors.white
                : Theme.of(context).textTheme.bodyText1.color),
      ),

      // child: AutolinkText(
      //   text: doc['content'],
      //   textStyle: TextStyle(
      //       color: doc['senderId'] == SharedPreferencesHelper.myUid()
      //           ? Colors.white
      //           : Theme.of(context).textTheme.bodyText1.color),
      //   linkStyle: TextStyle(color: Colors.blue),
      //   onWebLinkTap: (link) => print(link),
      //   onEmailTap: (link) => print(link),
      //   onPhoneTap: (link) => print(link),
      // ),
    );
  }
}
