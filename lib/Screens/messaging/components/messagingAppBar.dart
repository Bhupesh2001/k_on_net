import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/components/profileImage.dart';
import '../../../constants.dart';

AppBar messagingAppBar({BuildContext context, doc}) {
  Size size = MediaQuery.of(context).size;
  return AppBar(
    backgroundColor:
        Theme.of(context).scaffoldBackgroundColor == kContentColorLightTheme
            ? kContentColorLightTheme
            : kPrimaryColor,
    title: InkWell(
      onTap: () {},
      child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('Users')
              .doc(doc['id'])
              .snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData)
              return Container(color: Theme.of(context).appBarTheme.color);
            var userDoc = snapshot.data;
            return AppBarDetails(size: size, userDoc: userDoc);
          }),
    ),
    actions: [
      IconButton(icon: Icon(Icons.phone), onPressed: () {}),
      IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
      SizedBox(width: size.width * 0.04),
    ],
  );
}

class AppBarDetails extends StatelessWidget {
  const AppBarDetails({
    Key key,
    @required this.size,
    @required this.userDoc,
  }) : super(key: key);

  final Size size;
  final userDoc;

  @override
  Widget build(BuildContext context) {
    bool isOnline = userDoc['isOnline'] ?? false;
    bool isTyping = userDoc['isTyping'] ?? false;
    return Row(
      children: [
        ProfileImage(),
        SizedBox(width: size.width * 0.02),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(userDoc["name"] ?? '', style: TextStyle(fontSize: 16)),
            Text(
              isTyping
                  ? 'Typing'
                  : isOnline
                      ? 'Online'
                      : timeInAgoFormat(userDoc['lastOnline']),
              style: TextStyle(fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}
