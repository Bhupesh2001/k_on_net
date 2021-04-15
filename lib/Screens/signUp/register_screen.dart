import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoom.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'package:k_on_net/constants.dart';
import 'background.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'userDetailScreen.dart';

class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController tecPhone = new TextEditingController();
  TextEditingController tecOtp = new TextEditingController();
  bool isLoading = false;
  bool otpSent = false;
  String _verificationCode;

  _verifyOtp(String pin) async {
    try {
      await FirebaseAuth.instance
          .signInWithCredential(PhoneAuthProvider.credential(
              verificationId: _verificationCode, smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => UserDetailsScreen()),
              (route) => false);
        }
      });
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Wrong OTP",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
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
              Navigator.pushNamedAndRemoveUntil(
                  context, ChatRoom.id, (route) => false);
            }
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          print(e.message);
        },
        codeSent: (String verficationID, int resendToken) {
          setState(() {
            _verificationCode = verficationID;
            otpSent = true;
          });
        },
        codeAutoRetrievalTimeout: (String verificationID) {
          setState(() {
            _verificationCode = verificationID;
          });
        },
        timeout: Duration(seconds: 90));
  }

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
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RoundedInputField(
                              hintText: 'Phone',
                              textInputType: TextInputType.phone,
                              onChanged: (value) {},
                              controller: tecPhone,
                            ),
                            SizedBox(height: size.height * 0.03),
                            RoundedInputField(
                              onChanged: (value) {},
                              obscureText: true, // typing becomes hidden
                              hintText: 'OTP',
                              textInputType: TextInputType.number,
                              controller: tecOtp,
                              icon: Icons.lock,
                            ),
                          ],
                        ),
                      ),
                      RoundedButton(
                          text: otpSent ? 'Verify' : 'Send OTP',
                          color: kPrimaryColor,
                          textColor: Colors.white,
                          press: () {
                            if (otpSent) {
                              if (tecOtp.text.length == 6)
                                _verifyOtp(tecOtp.text);
                              else {
                                Fluttertoast.showToast(
                                    msg: "Enter a valid OTP",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              }
                            } else if (tecPhone.text.length == 10)
                              _sendOtp(tecPhone.text);
                            else {
                              Fluttertoast.showToast(
                                  msg: "Enter a valid Phone Number",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0);
                            }
                          }),
                      SizedBox(height: size.height * 0.03),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
