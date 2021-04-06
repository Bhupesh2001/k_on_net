import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoom.dart';
import 'package:k_on_net/Screens/login/components/background.dart';
import 'package:k_on_net/Screens/signUp/signup_screen.dart';
import 'package:k_on_net/components/already_have_an_account_check.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'package:k_on_net/services/auth.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tecEmail = new TextEditingController();
  TextEditingController tecPassword = new TextEditingController();
  bool isLoading = false;
  AuthMethods authMethods = new AuthMethods();
  logMeIn() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
    }
    authMethods.signInWithEmail(tecEmail.text, tecPassword.text);
    print("Status = " + authMethods.signInSuccessful().toString());
    if (authMethods.signInSuccessful()) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => ChatRoom(),
        ),
        (route) => false,
      );
    } else {
      print("Login Failed\n");
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        : SingleChildScrollView(
            child: Background(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.03),
                  SvgPicture.asset(
                    "assets/icons/login.svg",
                    height: size.height * 0.35,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        RoundedInputField(
                          hintText: 'Email',
                          onChanged: (value) {},
                          controller: tecEmail,
                          validator: (String val) {
                            return val.isEmpty ||
                                    !(val.contains('@') && val.contains('.'))
                                ? 'Enter a valid Email'
                                : null;
                          },
                        ),
                        RoundedInputField(
                          onChanged: (value) {},
                          obscureText: true, // typing becomes hidden
                          hintText: 'password',
                          controller: tecPassword,
                          icon: Icons.lock,
                          validator: (String val) {
                            return val.isEmpty || val.length < 6
                                ? 'Enter a bigger password, atleast of 6'
                                : null;
                          },
                          suffixIcon: Icons.visibility_off,
                        ),
                      ],
                    ),
                  ),
                  RoundedButton(
                    text: 'Login',
                    press: logMeIn,
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    press: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => SignUpScreen(),
                        ),
                      );
                    },
                  )
                ],
              ),
            ),
          );
  }
}
