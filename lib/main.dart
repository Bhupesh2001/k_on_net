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
import 'package:shared_preferences/shared_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferencesHelper.spObject = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
          popupMenuTheme: PopupMenuThemeData(color: Colors.white)),
      darkTheme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: kContentColorLightTheme,
        hintColor: kContentColorLightTheme.withOpacity(0.3),
        popupMenuTheme: PopupMenuThemeData(
          color: kContentColorLightTheme.withOpacity(0.9),
        ),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
            .apply(bodyColor: kContentColorDarkTheme),
      ),

      home: SharedPreferencesHelper.isLoggedIn()
          ? SharedPreferencesHelper.isDetailsFilled()
              ? ChatRoomMain()
              : UserDetailsScreen(null, null)
          : WelcomeScreen(),
      // home: RegisterScreen(),
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

//scroll
// login error
