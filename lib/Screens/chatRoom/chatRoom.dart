import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:k_on_net/Screens/Welcome/welcome_screen.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/constants.dart';

class ChatRoom extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 20,
        title: Text('K-On-Net'),
      ),
      body: Column(
        children: [
          RoundedButton(
            text: 'Sign Out',
            press: () {
              Navigator.pushNamedAndRemoveUntil(
                  context, WelcomeScreen.id, (route) => false);
            },
          ),
          Center(
            child: widgetOptions.elementAt(_selectedIndex),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: GNav(
              rippleColor: kPrimaryLightColor,
              hoverColor: kPrimaryColor,
              gap: 8,
              activeColor: kPrimaryColor,
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              duration: Duration(milliseconds: 400),
              tabBackgroundColor: kPrimaryLightColor,
              tabs: [
                GButton(
                  icon: Icons.connect_without_contact,
                  text: 'Konnections',
                ),
                GButton(
                  icon: Icons.group,
                  text: 'Groups',
                ),
                GButton(
                  icon: Icons.person,
                  text: 'Profile',
                ),
                GButton(
                  icon: Icons.fiber_new_outlined,
                  text: 'Extra',
                ),
              ],
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
