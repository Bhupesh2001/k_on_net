import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefHelper {
  static SharedPreferences spObject;

  static void initialize() async =>
      spObject = await SharedPreferences.getInstance();

  static bool isLoggedIn() {
    if (spObject.getBool('isLoggedIn') != null)
      return spObject.getBool('isLoggedIn');
    return false;
  }

  static void setCurrentLoginData(String phone, String uid) {
    spObject.setString('currentUserPhone', phone);
    spObject.setString('myUid', uid);
  }

  static void setCurrentProfileData(String name, String team) {
    spObject.setString('currentUserName', name);
    spObject.setString('currentUserTeam', team);
  }

  static String myUid() => spObject.getString('myUid');
}
