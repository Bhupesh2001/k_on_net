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

  static void setCurrentLoginData(String phone, String uid) async {
    await spObject.setString('currentUserPhone', phone);
    await spObject.setString('myUid', uid);
  }

  static void setCurrentProfileData(String name, String team) async {
    await spObject.setString('currentUserName', name);
    await spObject.setString('currentUserTeam', team);
  }

  static void signOut() async {
    await spObject.setBool('isLoggedIn', false);
    await spObject.setBool('detailsFilled', false);
  }

  static String myUid() => spObject.getString('myUid');
}
