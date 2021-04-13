import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:k_on_net/Screens/components/background.dart';
import 'package:k_on_net/Screens/login/login_screen.dart';
import 'package:k_on_net/Screens/signUp/register_screen.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../constants.dart';

class WelcomeScreen extends StatefulWidget {
  static String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  // AnimationController controller;
  @override
  void initState() {
    super.initState();
    //   controller = AnimationController(
    //     vsync: this,
    //     lowerBound: 0.35,
    //     upperBound: 0.45,
    //     duration: Duration(milliseconds: 800),
    //   );
    //   controller.forward();
    //   controller.addListener(() {
    //     setState(() {});
    //   });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
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
              // RoundedButton(
              //   text: 'LOGIN',
              //   press: () {
              //     Navigator.pushNamed(context, LoginScreen.id);
              //   },
              // ),
              RoundedButton(
                text: 'SIGN UP',
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {
                  Navigator.pushNamed(context, RegisterScreen.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
