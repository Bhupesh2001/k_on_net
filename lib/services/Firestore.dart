import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:k_on_net/utility/shared_Preferences.dart';

class FireStoreHelper {
  static String groupChatId;

  static String getGroupChatId(DocumentSnapshot docs) {
    String userID = SharedPreferencesHelper.myUid();
    String anotherUserId = docs['id'];

    if (userID.compareTo(anotherUserId) > 0)
      groupChatId = '$userID - $anotherUserId';
    else
      groupChatId = '$anotherUserId - $userID';

    return groupChatId;
  }

  static Future<void> createRoom(DocumentSnapshot docs) async {
    getGroupChatId(docs);
    CollectionReference users = FirebaseFirestore.instance
        .collection('Messages')
        .doc(groupChatId)
        .collection(groupChatId);

    if (await users.snapshots().length == 0) {
      users.add({});
    }
  }

  static Future<void> userSetup(
      {String displayName, String teamName, String uid, String phone}) async {
    final result = (await FirebaseFirestore.instance
            .collection('users')
            .where('id', isEqualTo: uid)
            .get())
        .docs;

    if (result.length == 0) {
      FirebaseFirestore.instance.collection('Users').doc(uid).set({
        'name': displayName,
        'id': uid,
        'teamName': teamName,
        'isOnline': true,
        'lastOnline': '',
        'lastMessageTime': '',
        'profile_pic': '',
        'isTyping': false
      });
    }
    SharedPreferencesHelper.setCurrentLoginData(phone, uid);
    SharedPreferencesHelper.setCurrentProfileData(displayName, teamName);
    SharedPreferencesHelper.spObject.setBool('detailsFilled', true);
    return;
  }

  static Stream<QuerySnapshot> get user {
    return FirebaseFirestore.instance.collection("Users").snapshots();
  }
}
