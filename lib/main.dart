import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k_on_net/Screens/Welcome/welcome_screen.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoomMain.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/Screens/signUp/register_screen.dart';
import 'package:k_on_net/Screens/signUp/userDetailScreen.dart';
import 'package:k_on_net/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  final SharedPreferences preferences = await SharedPreferences.getInstance();
  print("isLogged in while opening app: " +
      preferences.getBool('isLoggedIn').toString());
  runApp(MyApp(preferences1: preferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences preferences1;

  const MyApp({Key key, this.preferences1}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'K-On-Net Auth',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: Colors.black),
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white.withOpacity(0.98),
      ),
      darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kContentColorLightTheme,
          hintColor: kContentColorLightTheme.withOpacity(0.3),
          textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
              .apply(bodyColor: kContentColorDarkTheme)),
      home: preferences1.getBool('isLoggedIn') == null ||
              preferences1.getBool('isLoggedIn') == false
          ? WelcomeScreen()
          : ChatRoomMain(),
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        ChatRoomMain.id: (context) => ChatRoomMain(),
        RegisterScreen.id: (context) => RegisterScreen(),
        UserDetailsScreen.id: (context) => UserDetailsScreen(),
        MessageScreen.id: (context) => MessageScreen(),
      },
    );
  }
}
