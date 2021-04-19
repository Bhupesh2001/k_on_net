import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/components/profileImage.dart';

import '../../../constants.dart';

AppBar messagingAppBar(BuildContext context, Size size) => AppBar(
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor == kContentColorLightTheme
              ? kContentColorLightTheme
              : kPrimaryColor,
      title: Row(
        children: [
          ProfileImage(edgeLength: 0.1),
          SizedBox(width: size.width * 0.02),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Bhupesh',
                style: TextStyle(fontSize: 16),
              ),
              Text(
                '2 min ago',
                style: TextStyle(fontSize: 12),
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(icon: Icon(Icons.phone), onPressed: () {}),
        IconButton(icon: Icon(Icons.videocam), onPressed: () {}),
        SizedBox(width: size.width * 0.04),
      ],
    );
