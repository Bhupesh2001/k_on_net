import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:k_on_net/Screens/chatRoom/chatScreen.dart';
import 'package:k_on_net/Screens/chatRoom/components/searchData.dart';
import 'package:k_on_net/constants.dart';
import 'components/popupMenu.dart';

class ChatRoomMain extends StatefulWidget {
  static String id = 'chat_screen';
  @override
  _ChatRoomMainState createState() => _ChatRoomMainState();
}

class _ChatRoomMainState extends State<ChatRoomMain> {
  int _selectedIndex = 0;
  xyz() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor == kContentColorLightTheme
                ? kContentColorLightTheme
                : kPrimaryColor,
        automaticallyImplyLeading: false,
        elevation: 20,
        title: Text(
          'K-On-Net',
          style: TextStyle(letterSpacing: 1, color: Colors.white),
        ),
        actions: [PopupMenu()],
      ),
      body: ChatScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showSearch(context: context, delegate: SearchData());
        },
        backgroundColor: kSecondaryColor,
        child: Icon(
          Icons.search,
          color: kPrimaryColor,
        ),
      ),
      bottomNavigationBar: Container(
        height: MediaQuery.of(context).size.height * 0.08,
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1))
        ]),
        child: SafeArea(
          child: GNav(
            backgroundColor:
                Theme.of(context).scaffoldBackgroundColor.withOpacity(0.98),
            rippleColor: kSecondaryColor,
            hoverColor: kPrimaryColor,
            gap: 8,
            activeColor: kPrimaryColor,
            iconSize: 24,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            duration: Duration(milliseconds: 400),
            tabBackgroundColor: Theme.of(context).scaffoldBackgroundColor ==
                    kContentColorLightTheme
                ? kContentColorLightTheme.withOpacity(0.8)
                : kSecondaryColor,
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
            onTabChange: (index) {},
          ),
        ),
      ),
    );
  }
}
