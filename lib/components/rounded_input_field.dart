import 'package:flutter/material.dart';
import 'package:k_on_net/components/text_field_container.dart';
import 'package:k_on_net/constants.dart';

class RoundedInputField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final int maxLength;
  final IconData suffixIcon;
  final bool obscureText;
  final Function validator;
  final TextEditingController controller;
  final TextInputType textInputType;
  final ValueChanged<String> onChanged;
  const RoundedInputField({
    Key key,
    this.textInputType,
    this.hintText,
    this.icon = Icons.person,
    this.onChanged,
    this.suffixIcon,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        style: TextStyle(color: kPrimaryColor, fontWeight: FontWeight.bold),
        maxLength: maxLength,
        buildCounter: (BuildContext context,
                {int currentLength, int maxLength, bool isFocused}) =>
            null,
        cursorColor: kPrimaryColor,
        controller: controller,
        validator: validator,
        keyboardType: textInputType,
        onChanged: onChanged,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintStyle:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.normal),
          hintText: hintText,
          border: InputBorder.none,
          icon: Icon(
            icon,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            suffixIcon,
            color: kPrimaryColor,
          ),
        ),
      ),
    );
  }
}
