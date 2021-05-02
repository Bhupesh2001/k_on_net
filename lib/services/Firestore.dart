import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

class FireStoreHelper {
  static String _groupChatId;

  static String getGroupChatId(DocumentSnapshot docs) {
    print("getGroupChatIdStarted");
    String userID = SharedPreferencesHelper.myUid();
    String anotherUserId = docs['id'];

    if (userID.compareTo(anotherUserId) > 0)
      _groupChatId = '$userID - $anotherUserId';
    else
      _groupChatId = '$anotherUserId - $userID';

    return _groupChatId;
  }

  static Future<void> createRoom(DocumentSnapshot docs) async {
    getGroupChatId(docs);
    CollectionReference users = FirebaseFirestore.instance
        .collection('Messages')
        .doc(_groupChatId)
        .collection(_groupChatId);

    print(_groupChatId);

    if (await users.snapshots().length == 0) {
      print("IF");
      users.add({});
    }
  }
}
