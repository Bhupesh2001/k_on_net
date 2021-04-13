import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'package:k_on_net/constants.dart';
import 'background.dart';
import 'userDetailScreen.dart';

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
                              textInputType: TextInputType.phone,
                              onChanged: (value) {},
                              controller: tecPhone,
                              validator: (String val) {
                                return val.length != 10
                                    ? 'Enter a valid Phone Number'
                                    : null;
                              },
                            ),
                            RoundedButton(
                              text: 'Send OTP',
                              color: kPrimaryColor,
                              textColor: Colors.white,
                              press: () {
                                //  TODO: pass tecPhone in function to request otp
                              },
                            ),
                            SizedBox(height: size.height * 0.03),
                            RoundedInputField(
                              onChanged: (value) {},
                              obscureText: true, // typing becomes hidden
                              hintText: 'OTP',
                              textInputType: TextInputType.number,
                              controller: tecOtp,
                              icon: Icons.lock,
                              validator: (String val) {
                                return val.length < 6
                                    ? 'Enter a valid OTP'
                                    : null;
                              },
                            ),
                          ],
                        ),
                      ),
                      RoundedButton(
                        text: 'Verify',
                        color: kPrimaryColor,
                        textColor: Colors.white,
                        press: () {
                          // TODO: pass tecOtp in otp verify function, and put a condition if success then next page
                          Navigator.pushNamedAndRemoveUntil(
                              context, UserDetailsScreen.id, (route) => false);
                        },
                      ),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
