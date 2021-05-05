import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:k_on_net/Screens/chatRoom/chatScreen.dart';
import 'package:timeago/timeago.dart' as timeago;

const kPrimaryColor = Color(0xFF6f35a5);
const kSecondaryColor = Color(0xFFf1e6ff);
const kContentColorLightTheme = Color(0xff1d1d35);
const kContentColorDarkTheme = Color(0xfff5fcf9);
const kTopNavBarTextStyle =
    TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white);
const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
List<Widget> widgetOptions = <Widget>[
  ChatScreen(),
  Text(
    'Groups',
    style: optionStyle,
  ),
  Text(
    'Profile',
    style: optionStyle,
  ),
  Text(
    'Extra',
    style: optionStyle,
  ),
];

flutterToast(String message) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: kSecondaryColor,
    textColor: Colors.white,
    fontSize: 16.0);

String timeInHourMinFormat(Timestamp time) =>
    (time.toDate().hour % 12).toString() +
    ":" +
    time.toDate().minute.toString() +
    (time.toDate().hour % 12 == time.toDate().hour ? ' am' : ' pm');

String timeInAgoFormat(Timestamp time) =>
    timeago.format(DateTime.tryParse(time.toDate().toString())).toString();
