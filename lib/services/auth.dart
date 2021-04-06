import 'package:firebase_auth/firebase_auth.dart';
import 'package:k_on_net/model/user.dart';

class AuthMethods {
  bool signSuccessful = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User _userFromFirebaseUser(FirebaseUser user) {
    return user == null ? null : User(userId: user.uid);
  }

  Future signInWithEmail(String email, String password) async {
    try {
      print("1\n");
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("2\n");
      FirebaseUser firebaseUser = result.user;
      print("2\n");
      print("UID = " + firebaseUser.uid);
      print("3\n");
      print(" Before Status = " + signSuccessful.toString());
      signSuccessful = true;
      print(" After Status = " + signSuccessful.toString());
      print("4\n");
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print("Error" + e.toString());
    }
  }

  Future signUpWithEmail(String email, String password) async {
    try {
      print("1\n");
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("2\n");
      FirebaseUser firebaseUser = result.user;
      print("2\n");
      signSuccessful = true;
      print("3\n");
      return _userFromFirebaseUser(firebaseUser);
    } catch (e) {
      print(e.toString());
    }
  }

  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }

  bool signInSuccessful() => signSuccessful;
}
