import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:k_on_net/Screens/Welcome/welcome_screen.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoomMain.dart';
import 'package:k_on_net/Screens/messaging/messageScreen.dart';
import 'package:k_on_net/Screens/signUp/register_screen.dart';
import 'package:k_on_net/Screens/signUp/userDetailScreen.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp();
  SharedPreferencesHelper.initialize();
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
      home: SharedPreferencesHelper.isLoggedIn()
          ? SharedPreferencesHelper.isDetailsFilled()
              ? ChatRoomMain()
              : UserDetailsScreen()
          : WelcomeScreen(),
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
