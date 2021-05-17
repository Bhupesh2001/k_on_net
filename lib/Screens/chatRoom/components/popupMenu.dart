import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/Welcome/welcome_screen.dart';
import 'package:k_on_net/Screens/chatRoom/components/searchNew.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/utility/contacts.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';
import 'package:permission_handler/permission_handler.dart';

enum MenuOption { Theme, Logout }

class PopupMenu extends StatefulWidget {
  @override
  _PopupMenuState createState() => _PopupMenuState();
}

class _PopupMenuState extends State<PopupMenu> {
  @override
  Widget build(BuildContext context) {
    void _signOut() async {
      Navigator.pop(context);
      FirebaseAuth.instance.signOut();
      FirebaseFirestore.instance
          .collection("Users")
          .doc(SharedPrefHelper.myUid())
          .update({"isOnline": false}).then((_) {});
      Navigator.pushNamedAndRemoveUntil(
          context, WelcomeScreen.id, (route) => false);
    }

    return PopupMenuButton(onSelected: (MenuOption m) {
      Navigator.pop(context);
    }, itemBuilder: (BuildContext context) {
      return <PopupMenuEntry<MenuOption>>[
        PopupMenuItem(
          child: ListTile(
            leading: Icon(Icons.person_add),
            title: Text('New Chat'),
            onTap: () async {
              Navigator.pop(context);
              final PermissionStatus permission =
                  await ContactUtils.getContactPermission();
              if (permission.isGranted) {
                List<String> numbers = [];
                List<String> names = [];
                Iterable<Contact> contacts =
                    await ContactsService.getContacts(withThumbnails: false);
                List<Contact> contactsList = contacts.toList();

                for (int i = 0; i < contactsList.length; i++) {
                  numbers.add(contactsList[i]
                      .phones
                      .first
                      .value
                      .toString()
                      .replaceAll(" ", "")
                      .replaceAll(')', "")
                      .replaceAll("(", "")
                      .replaceAll("-", ""));
                  names.add(contactsList[i].displayName);
                }
                ContactUtils.phoneNum = numbers;
                ContactUtils.phoneNames = names;
                showSearch(
                    context: context, delegate: SearchNew(numbers, names));
              } else {
                flutterToast("Allow contacts from settings");
              }
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
