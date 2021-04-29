import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences spObject;

  static void initialize() async =>
      spObject = await SharedPreferences.getInstance();

  static bool isLoggedIn() => (spObject.getBool('isLoggedIn') ?? false);

  static bool isDetailsFilled() => (spObject.getBool('detailsFilled') ?? false);

  static loginSuccessful() async => spObject.setBool('isLoggedIn', true);

  static void setCurrentLoginData(String phone, String uid) {
    spObject.setString('currentUserPhone', phone);
    spObject.setString('currentUserUID', uid);
  }

  static void setCurrentProfileData(String name, String team) {
    spObject.setString('currentUserName', name);
    spObject.setString('currentUserTeam', team);
  }

  static void signOut() {
    spObject.setBool('isLoggedIn', false);
    spObject.setBool('detailsFilled', false);
  }
}
