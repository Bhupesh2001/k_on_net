import 'package:flutter/material.dart';
import 'package:k_on_net/Screens/Welcome/welcome_screen.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoom.dart';
import 'package:k_on_net/Screens/signUp/register_screen.dart';
import 'package:k_on_net/Screens/signUp/userDetailScreen.dart';
import 'package:k_on_net/constants.dart';
import 'package:firebase_core/firebase_core.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // FirebaseUser user;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'K-On-Net Auth',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: WelcomeScreen(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatRoom.id: (context) => ChatRoom(),
        RegisterScreen.id: (context) => RegisterScreen(),
        UserDetailsScreen.id: (context) => UserDetailsScreen(),
      },
    );
  }
}
