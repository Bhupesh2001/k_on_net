import 'package:permission_handler/permission_handler.dart';
import '../constants.dart';

class ContactUtils {
  static List<String> phoneNum = [];
  static List<String> phoneNames = [];
  static Future getContactPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    if (permission.isDenied) {
      final newPermission = await Permission.contacts.request();
      return newPermission;
    } else {
      return permission;
    }
  }

  static Future askContactsPermission() async {
    final permission = await ContactUtils.getContactPermission();
    if (permission == PermissionStatus.denied)
      flutterToast("Please allow contacts");
  }
}
