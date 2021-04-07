import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoom.dart';
import 'package:k_on_net/Screens/signUp/register_screen.dart';
import 'package:k_on_net/components/already_have_an_account_check.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'background.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tecEmail = new TextEditingController();
  TextEditingController tecPassword = new TextEditingController();
  bool isLoading = false;

  logMeIn() =>
      Navigator.pushNamedAndRemoveUntil(context, ChatRoom.id, (route) => false);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return isLoading
        ? Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: SingleChildScrollView(
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
                        Navigator.pushNamedAndRemoveUntil(
                            context, RegisterScreen.id, (route) => false);
                      },
                    )
                  ],
                ),
              ),
            ),
          );
  }
}
