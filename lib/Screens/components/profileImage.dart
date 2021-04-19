import 'package:flutter/material.dart';

class ProfileImage extends StatelessWidget {
  final Image image;
  final double edgeLength; // should be between 0 and 1
  const ProfileImage({Key key, this.image, this.edgeLength = 0.12})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: image,
      height: size.width * edgeLength,
      width: size.width * edgeLength,
      decoration: BoxDecoration(
          color: Colors.blue,
          shape: BoxShape.rectangle,
          borderRadius:
              BorderRadius.all(Radius.circular(size.width * 0.09 / 4))),
    );
  }
}
