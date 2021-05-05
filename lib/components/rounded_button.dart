import 'package:flutter/material.dart';
import '../constants.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    Key key,
    this.color = kPrimaryColor,
    this.text,
    this.press,
    this.textColor = Colors.white,
  }) : super(key: key);

  final Color color;
  final Function press;
  final String text;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return MaterialButton(
      onPressed: press,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        ),
        margin: EdgeInsets.symmetric(vertical: 10),
        width: size.width * 0.8,
        height: 53,
        // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
