import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:k_on_net/components/loadingIndicator.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';
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
  bool otpSent = false;
  String _verificationCode;

  _verifyOtp(String pin) async {
    try {
      setState(() {
        isLoading = true;
      });
      FirebaseAuth auth = FirebaseAuth.instance;
      await auth
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          SharedPreferencesHelper.loginSuccessful();
          SharedPreferencesHelper.setCurrentLoginData(
              tecPhone.text, auth.currentUser.uid);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      UserDetailsScreen(tecPhone.text, auth.currentUser.uid)),
              (route) => false);
        }
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      flutterToast('Wrong OTP');
    }
  }

  _sendOtp(String phone) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '+91$phone',
        verificationCompleted: (PhoneAuthCredential credential) async {
          await FirebaseAuth.instance
              .signInWithCredential(credential)
              .then((value) async {
            if (value.user != null) {
              FirebaseAuth auth = FirebaseAuth.instance;
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                      builder: (context) => UserDetailsScreen(
                          tecPhone.text, auth.currentUser.uid)),
                  (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            isLoading = false;
          });
          flutterToast(e.message);
        },
        codeSent: (String verificationID, int resendToken) {
          setState(() {
            _verificationCode = verificationID;
            otpSent = true;
            isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            isLoading = false;
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 90));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: size.height * 0.03),
                SvgPicture.asset(
                  'assets/icons/signup.svg',
                  height: size.height * 0.35,
                ),
                Form(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          RoundedInputField(
                            hintText: 'Phone',
                            textInputType: TextInputType.phone,
                            controller: tecPhone,
                            maxLength: 10,
                          ),
                          Positioned(
                            right: 20,
                            child: LoadingIndicator(
                              isLoading: isLoading,
                              radius: 15,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: size.height * 0.015),
                      RoundedInputField(
                        obscureText: true,
                        hintText: 'OTP',
                        textInputType: TextInputType.number,
                        controller: tecOtp,
                        icon: Icons.lock,
                        maxLength: 6,
                      ),
                    ],
                  ),
                ),
                Hero(
                  tag: 'button',
                  child: RoundedButton(
                      text: otpSent ? 'Verify' : 'Send OTP',
                      color: kPrimaryColor,
                      textColor: Colors.white,
                      press: () {
                        if (otpSent) {
                          if (tecOtp.text.length == 6) {
                            setState(() {
                              isLoading = true;
                            });
                            _verifyOtp(tecOtp.text);
                          } else {
                            flutterToast("Enter a valid OTP");
                          }
                        } else if (tecPhone.text.length == 10) {
                          setState(() {
                            isLoading = true;
                          });
                          _sendOtp(tecPhone.text);
                        } else
                          flutterToast("Enter a valid Phone number");
                      }),
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
