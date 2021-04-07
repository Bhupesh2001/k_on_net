import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoom.dart';
import 'package:k_on_net/Screens/login/login_screen.dart';
import 'file:///D:/K%20On%20Net%20OFFICIAL/k_on_net/lib/Screens/signUp/background.dart';
import 'package:k_on_net/components/already_have_an_account_check.dart';
import 'package:k_on_net/components/or_divider.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'package:k_on_net/constants.dart';

// class RegisterScreen extends StatelessWidget {
//   static String id = 'register_screen';
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Body(
//         child: Column(),
//       ),
//     );
//   }
// }
class RegisterScreen extends StatefulWidget {
  static String id = 'register_screen';
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController tecEmail = new TextEditingController();
  TextEditingController tecPassword = new TextEditingController();
  bool isLoading = false;
  signMeUp() {
    if (formKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
    }
    Navigator.pushNamedAndRemoveUntil(context, ChatRoom.id, (route) => false);
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
                      SizedBox(
                        height: size.height * 0.03,
                      ),
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
                              hintText: 'Email',
                              onChanged: (value) {},
                              controller: tecEmail,
                              validator: (String val) {
                                return val.isEmpty ||
                                        !(val.contains('@') &&
                                            val.contains('.'))
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
                      GestureDetector(
                        onTap: () {},
                        child: RoundedButton(
                          text: 'SIGN UP',
                          press: signMeUp,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      AlreadyHaveAnAccountCheck(
                        login: false,
                        press: () {
                          Navigator.pushNamedAndRemoveUntil(
                              context, LoginScreen.id, (route) => false);
                        },
                      ),
                      OrDivider(),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 2,
                              color: kPrimaryLightColor,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: SvgPicture.asset(
                            'assets/icons/google-plus.svg',
                            width: 20,
                            height: 20,
                            color: kPrimaryColor,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
