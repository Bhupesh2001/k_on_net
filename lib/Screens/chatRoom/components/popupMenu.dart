import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/Welcome/welcome_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum MenuOption { Theme, Logout }

class PopupMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setBool('isLoggedIn', false);
      await FirebaseAuth.instance.signOut();
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.id, (route) => false);
    }

    return PopupMenuButton(itemBuilder: (BuildContext context) {
      return <PopupMenuEntry<MenuOption>>[
        PopupMenuItem(
          child: ListTile(
            leading: Icon(
              Theme.of(context) == ThemeData.dark()
                  ? Icons.nightlight_round
                  : Icons.wb_sunny,
            ),
            title: Text('Theme'),
            onTap: () {},
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
