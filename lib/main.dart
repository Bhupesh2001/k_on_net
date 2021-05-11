import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k_on_net/Screens/Welcome/welcome_screen.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoomMain.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/Screens/signUp/register_screen.dart';
import 'package:k_on_net/Screens/signUp/userDetailScreen.dart';
import 'package:k_on_net/themeData.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPrefHelper.spObject = await SharedPreferences.getInstance();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: kPrimaryColor));
  FirebaseAuth _auth = FirebaseAuth.instance;
  bool isLoggedIn() {
    if (_auth.currentUser == null) return false;
    return true;
  } // status bar color

  runApp(MyApp(isLoggedIn()));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  MyApp(this.isLoggedIn);
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void dispose() {
    WidgetsBinding.instance.addObserver(this);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("the state of app : $state");

    if (state == AppLifecycleState.resumed) {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(SharedPrefHelper.myUid())
          .update({"isOnline": true}).then((_) {
        print("success resumed");
      });
    } else {
      FirebaseFirestore.instance
          .collection('Users')
          .doc(SharedPrefHelper.myUid())
          .update({"isOnline": false, 'lastOnline': DateTime.now()}).then((_) {
        print("success Paused");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'K-On-Net',
      theme: lightTheme(context),
      darkTheme: darkTheme(context),
      home: widget.isLoggedIn ? ChatRoomMain() : WelcomeScreen(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatRoomMain.id: (context) => ChatRoomMain(),
        RegisterScreen.id: (context) => RegisterScreen(),
        UserDetailsScreen.id: (context) => UserDetailsScreen(null, null),
        MessageScreen.id: (context) => MessageScreen(null),
      },
    );
  }
}

// ticks
// login error
