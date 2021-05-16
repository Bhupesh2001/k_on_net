import 'package:contacts_service/contacts_service.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constants.dart';

class ContactUtils {
  static List<String> phoneNum = [];

  static Future getContactPermission() async {
    final PermissionStatus permission = await Permission.contacts.status;
    print(permission);
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

  static void printContactsNumber() async {
    Iterable<Contact> contacts =
        await ContactsService.getContacts(withThumbnails: false);
    List<Contact> contactsList = contacts.toList();

    for (int i = 0; i < contactsList.length; i++) {
      phoneNum.add(contactsList[i].phones.first.value.toString());
    }
  }
}
