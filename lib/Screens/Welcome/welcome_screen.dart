import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:k_on_net/Screens/components/background.dart';
import 'package:k_on_net/Screens/login/login_screen.dart';
import 'package:k_on_net/Screens/signUp/register_screen.dart';
import 'package:k_on_net/components/rounded_button.dart';

import '../../constants.dart';

class WelcomeScreen extends StatelessWidget {
  static String id = 'welcome_screen';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Welcome To K-On-Net",
                style: TextStyle(
                    fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              SvgPicture.asset(
                "assets/icons/chat.svg",
                height: size.height * 0.45,
              ),
              SizedBox(
                height: size.height * 0.05,
              ),
              RoundedButton(
                text: 'LOGIN',
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return LoginScreen();
                    }),
                  );
                },
              ),
              RoundedButton(
                text: 'SIGN UP',
                color: kPrimaryLightColor,
                textColor: Colors.black,
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return RegisterScreen();
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
