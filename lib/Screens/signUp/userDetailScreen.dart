import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:k_on_net/Screens/chatRoom/chatRoomMain.dart';
import 'package:k_on_net/Screens/login/background.dart';
import 'package:k_on_net/components/loadingIndicator.dart';
import 'package:k_on_net/components/rounded_button.dart';
import 'package:k_on_net/components/rounded_input_field.dart';
import 'package:k_on_net/constants.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

class UserDetailsScreen extends StatefulWidget {
  static String id = 'userDetailsScreen';
  final String uid;
  final String phone;

  const UserDetailsScreen(this.phone, this.uid);

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  bool isLoading = false;
  Future<void> userSetup(String displayName, String teamName) async {
    final result = (await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: widget.uid)
            .get())
        .docs;

    if (result.length == 0) {
      print("UID " + widget.uid);
      FirebaseFirestore.instance.collection('Users').doc(widget.uid).set({
        'name': displayName,
        'id': widget.uid,
        'teamName': teamName,
        'content': '',
        'isOnline': true,
        'lastMessageTime': '',
        'lastSeen': '',
        'profile_pic': ''
      });
    }
    SharedPreferencesHelper.setCurrentLoginData(widget.phone, widget.uid);
    SharedPreferencesHelper.setCurrentProfileData(displayName, teamName);
    SharedPreferencesHelper.spObject.setBool('detailsFilled', true);
    return;
  }

  onClick() {
    if (tecName.text.trim().length < 2) {
      flutterToast("Enter a valid name");
    } else {
      try {
        setState(() {
          isLoading = true;
        });
        if (!FocusScope.of(context).hasPrimaryFocus)
          FocusScope.of(context).unfocus();
        User updateUser = FirebaseAuth.instance.currentUser;
        updateUser.updateProfile(displayName: tecName.text);
        userSetup(tecName.text, tecTeam.text);
        Navigator.pushNamedAndRemoveUntil(
            context, ChatRoomMain.id, (route) => false);
      } catch (e) {
        setState(() {
          isLoading = false;
        });
        flutterToast(e.toString());
      }
    }
  }

  final formKey = GlobalKey<FormState>();
  TextEditingController tecName = new TextEditingController();
  TextEditingController tecTeam = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
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
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Update  Your  Profile",
                    style: TextStyle(
                        fontWeight: FontWeight.w900,
                        letterSpacing: 3,
                        wordSpacing: 3),
                  ),
                  SizedBox(height: size.height * 0.06),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Container(
                      color: kSecondaryColor,
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
                            maxLength: 15,
                          ),
                          RoundedInputField(
                            onChanged: (value) {},
                            hintText: 'Team (optional)',
                            controller: tecTeam,
                            icon: Icons.lock,
                            maxLength: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: 'Finish',
                    press: () {
                      setState(() {
                        isLoading = !isLoading;
                      });
                    },
                  ),
                  SizedBox(height: size.height * 0.05),
                ],
              ),
            ),
          ),
          LoadingIndicator(isLoading: isLoading)
        ],
      ),
    );
  }
}
