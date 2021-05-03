import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String userName;
  final bool isOnline;
  final Timestamp lastMessageTime;
  final Timestamp lastOnline;
  final String teamName;
  final String profilePic;

  User(
    this.userId,
    this.isOnline,
    this.lastMessageTime,
    this.lastOnline,
    this.userName,
    this.profilePic,
    this.teamName,
  );
}
