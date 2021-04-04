import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:k_on_net/Screens/login/login_screen.dart';
import 'package:k_on_net/Screens/signUp/components/background.dart';
import 'package:k_on_net/Screens/signUp/components/or_divider.dart';
import 'package:k_on_net/components/already_have_an_account_check.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'package:k_on_net/constants.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({Key key, @required this.child}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
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
              RoundedInputField(
                hintText: 'Email',
                onChanged: (value) {},
              ),
              RoundedInputField(
                hintText: 'Password',
                obscureText: true,
                icon: Icons.lock,
                suffixIcon: Icons.visibility_off,
                onChanged: (value) {},
              ),
              GestureDetector(
                onTap: () {},
                child: RoundedButton(
                  text: 'SIGNUP',
                  press: () {},
                ),
              ),
              SizedBox(
                height: size.height * 0.03,
              ),
              AlreadyHaveAnAccountCheck(
                login: false,
                press: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return LoginScreen();
                      },
                    ),
                  );
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
    );
  }
}
