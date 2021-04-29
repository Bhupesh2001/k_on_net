import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences spObject;

  static void initialize() async =>
      spObject = await SharedPreferences.getInstance();

  static bool isLoggedIn() {
    if (spObject.getBool('isLoggedIn') != null)
      return spObject.getBool('isLoggedIn');
    return false;
  }

  static bool isDetailsFilled() {
    if (spObject.getBool('detailsFilled') != null)
      return spObject.getBool('detailsFilled');
    return false;
  }

  static loginSuccessful() async => spObject.setBool('isLoggedIn', true);

  static void setCurrentLoginData(String phone, String uid) {
    spObject.setString('currentUserPhone', phone);
    spObject.setString('myUid', uid);
  }

  static void setCurrentProfileData(String name, String team) {
    spObject.setString('currentUserName', name);
    spObject.setString('currentUserTeam', team);
  }

  static void signOut() {
    spObject.setBool('isLoggedIn', false);
    spObject.setBool('detailsFilled', false);
  }

  static String myUid() => spObject.getString('myUid');
}
