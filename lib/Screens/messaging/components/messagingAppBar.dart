import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/components/profileImage.dart';

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
      child: Row(
        children: [
          ProfileImage(),
          SizedBox(width: size.width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                doc['name'],
                style: TextStyle(fontSize: 16),
              ),
              Text(
                doc['isOnline'] ? 'Online' : doc['lastSeen'],
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    ),
    actions: [
      IconButton(icon: Icon(Icons.phone), onPressed: () {}),
      IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
      SizedBox(width: size.width * 0.04),
    ],
  );
}
