import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData lightTheme(BuildContext context) => ThemeData(
      accentColor: kPrimaryColor,
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: Colors.black),
      primaryColor: kPrimaryColor,
      scaffoldBackgroundColor: Colors.white.withOpacity(0.98),
      popupMenuTheme: PopupMenuThemeData(color: Colors.white),
    );

ThemeData darkTheme(BuildContext context) => ThemeData.dark().copyWith(
      accentColor: kPrimaryColor,
      scaffoldBackgroundColor: kContentColorLightTheme,
      hintColor: kContentColorLightTheme.withOpacity(0.3),
      popupMenuTheme: PopupMenuThemeData(
        color: kContentColorLightTheme.withOpacity(0.9),
      ),
      textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme)
          .apply(bodyColor: kContentColorDarkTheme),
    );
