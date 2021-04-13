import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoom.dart';
import 'package:k_on_net/Screens/login/background.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'package:k_on_net/constants.dart';

class UserDetailsScreen extends StatefulWidget {
  static String id = 'userDetailsScreen';
  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final formKey = GlobalKey<FormState>();
  TextEditingController tecName = new TextEditingController();
  TextEditingController tecPassword = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.2,
              child: SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height,
                width: size.width,
              ),
            ),
            Background(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Update  Your  Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                        letterSpacing: 3),
                  ),
                  SizedBox(height: size.height * 0.03),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: kPrimaryLightColor,
                      child: Image.asset(
                        'assets/images/person.png',
                        width: size.width * 0.17,
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Opacity(
                    opacity: 0.7,
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          RoundedInputField(
                            hintText: 'Name',
                            icon: Icons.person,
                            onChanged: (value) {},
                            controller: tecName,
                            validator: (String val) {
                              return val.length < 3
                                  ? 'Enter a valid name'
                                  : null;
                            },
                          ),
                          RoundedInputField(
                            onChanged: (value) {},
                            obscureText: true, // typing becomes hidden
                            hintText: 'Team (optional)',
                            controller: tecPassword,
                            icon: Icons.lock,
                          ),
                        ],
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: 'Finish',
                    press: () {
                      //TODO: get the name stored in tecName(name.length should be greater than 3, already implemented )
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, ChatRoom.id, (route) => false);
                    },
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
