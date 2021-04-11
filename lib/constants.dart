import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF6f35a5);
const kPrimaryLightColor = Color(0xFFf1e6ff);
const kTopNavBarTextStyle =
    TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white);
const TextStyle optionStyle =
    TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
const List<Widget> widgetOptions = <Widget>[
  Text(
    'Konnections',
    style: optionStyle,
  ),
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
