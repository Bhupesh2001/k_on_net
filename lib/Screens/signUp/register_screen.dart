import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:k_on_net/Screens/login/login_screen.dart';
import 'package:k_on_net/components/already_have_an_account_check.dart';
import 'package:k_on_net/components/googleSignInBtn.dart';
import 'package:k_on_net/components/or_divider.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'background.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tecPhone = new TextEditingController();
  TextEditingController tecOtp = new TextEditingController();
  bool isLoading = false;

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
              child: SafeArea(
                child: Background(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.03),
                      SvgPicture.asset(
                        'assets/icons/signup.svg',
                        height: size.height * 0.35,
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RoundedInputField(
                              hintText: 'Phone',
                              onChanged: (value) {},
                              controller: tecPhone,
                              validator: (String val) {
                                return val.length != 10
                                    ? 'Enter a valid Phone Number'
                                    : null;
                              },
                            ),
                            RoundedInputField(
                              onChanged: (value) {},
                              obscureText: true, // typing becomes hidden
                              hintText: 'OTP',
                              controller: tecOtp,
                              icon: Icons.lock,
                              validator: (String val) {
                                return val.length < 6
                                    ? 'Enter a valid OTP'
                                    : null;
                              },
                              suffixIcon: Icons.visibility_off,
                            ),
                          ],
                        ),
                      ),
                      RoundedButton(
                        text: 'SIGN UP',
                        press: () {},
                      ),
                      SizedBox(height: size.height * 0.03),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.popAndPushNamed(context, LoginScreen.id);
                        },
                      ),
                      OrDivider(),
                      googleSigninBtn(),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
