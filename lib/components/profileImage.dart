import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final Image image;
  final double edgeLength; // should be between 0 and 1
  const ProfileImage({Key key, this.image, this.edgeLength = 48})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Image.asset('assets/images/person.png'),
      height: edgeLength,
      width: edgeLength,
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(edgeLength * 0.28))),
    );
  }
}
