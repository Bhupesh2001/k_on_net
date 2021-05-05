import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/Welcome/welcome_screen.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

enum MenuOption { Theme, Logout }

class PopupMenu extends StatefulWidget {
  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      FirebaseAuth.instance.signOut();
      SharedPreferencesHelper.signOut();
      FirebaseFirestore.instance
          .collection("Users")
          .doc(SharedPreferencesHelper.myUid())
          .update({"isOnline": false}).then((_) {
        print("success!");
      });
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.id, (route) => false);
    }

    bool isLightTheme =
        SharedPreferencesHelper.spObject.getBool('lightTheme') ?? true;
    return PopupMenuButton(onSelected: (MenuOption m) {
      Navigator.pop(context);
    }, itemBuilder: (BuildContext context) {
      return <PopupMenuEntry<MenuOption>>[
        PopupMenuItem(
          child: ListTile(
            leading:
                Icon(isLightTheme ? Icons.wb_sunny : Icons.nightlight_round),
            title: Text('Theme'),
            onTap: () {
              Navigator.pop(context);
              SharedPreferencesHelper.spObject
                  .setBool('lightTheme', !isLightTheme);
              setState(() {
                isLightTheme =
                    SharedPreferencesHelper.spObject.getBool('lightTheme');
              });
              flutterToast("Restart the app to apply changes");
            },
          ),
        ),
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: _signOut,
          ),
        )
      ];
    });
  }
}
