import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
        child: Background(
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
              Form(
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
                        return val.length < 3 ? 'Enter a valid name' : null;
                      },
                    ),
                    RoundedInputField(
                      onChanged: (value) {},
                      obscureText: true, // typing becomes hidden
                      hintText: 'Socha nahi abhi',
                      controller: tecPassword,
                      icon: Icons.lock,
                      validator: (String val) {
                        return val.length != 6 ? 'Enter a 6 digit OTP' : null;
                      },
                    ),
                  ],
                ),
              ),
              RoundedButton(
                text: 'Login',
                press: () {},
              ),
              SizedBox(height: size.height * 0.05),
              SvgPicture.asset(
                "assets/icons/login.svg",
                height: size.height * 0.21,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
