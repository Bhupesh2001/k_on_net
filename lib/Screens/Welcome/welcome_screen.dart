import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:k_on_net/Screens/Welcome/background.dart';
import 'package:k_on_net/Screens/signUp/register_screen.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:k_on_net/utility/contacts.dart';
import '../../constants.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [
                TypewriterAnimatedText(
                  'Welcome',
                  textStyle: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TypewriterAnimatedText(
                  'To',
                  textStyle: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 28.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TypewriterAnimatedText(
                  'K-On-Net',
                  textStyle: const TextStyle(
                    color: kPrimaryColor,
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
              totalRepeatCount: 1,
              pause: const Duration(milliseconds: 1000),
              displayFullTextOnTap: true,
              stopPauseOnTap: true,
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            SvgPicture.asset(
              "assets/icons/chat.svg",
              height: size.height * 0.45, // for no animation
              // height:size.height * (0.93 - controller.value), // for animation
            ),
            SizedBox(
              height: size.height * 0.05,
            ),
            Hero(
              tag: 'button',
              child: RoundedButton(
                text: 'NEXT',
                press: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    ContactUtils.getContactPermission();
    super.initState();
  }
}
