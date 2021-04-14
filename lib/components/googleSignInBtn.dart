// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:k_on_net/Screens/chatRoom/chatRoom.dart';
// import 'package:k_on_net/services/auth.dart';
// import '../constants.dart';
//
// class googleSigninBtn extends StatelessWidget {
//   FirebaseUser user;
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         signInWithGoogle().then((user) => {
//               this.user = user,
//               // Navigator.push(context,
//               //     MaterialPageRoute(builder: (context) => ChatRoom(user))),
//               Navigator.pushAndRemoveUntil(
//                   context,
//                   MaterialPageRoute(builder: (context) => ChatRoom(user)),
//                   (route) => false)
//             });
//       },
//       child: Container(
//         alignment: Alignment.center,
//         padding: EdgeInsets.all(20),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 2,
//             color: kPrimaryLightColor,
//           ),
//           shape: BoxShape.circle,
//         ),
//         child: SvgPicture.asset(
//           'assets/icons/google-plus.svg',
//           width: 20,
//           height: 20,
//           color: kPrimaryColor,
//         ),
//       ),
//     );
//   }
// }
