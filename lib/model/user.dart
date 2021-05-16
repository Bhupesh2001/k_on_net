import 'package:cloud_firestore/cloud_firestore.dart';

class MyUser {
  String id;
  bool isOnline;
  String lastOnlineTime;
  String name;
  String phone;
  String teamName;
  MyUser(DocumentSnapshot doc) {
    id = doc['id'];
    isOnline = doc['isOnline'];
    lastOnlineTime = doc['lastOnline'];
    name = doc['name'];
    phone = doc['phone'];
    teamName = doc['teamName'];
  }
}
