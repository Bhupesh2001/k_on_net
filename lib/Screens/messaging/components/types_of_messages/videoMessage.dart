import 'package:flutter/material.dart';

import '../../../../constants.dart';

class VideoMessage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.45,
        child: AspectRatio(
          aspectRatio: 1.6,
          child: Stack(
            alignment: Alignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Opacity(
                  opacity: 0.8,
                  child: Image.network(
                      'https://i.ibb.co/7CXXdSZ/pexels-joyston-judah-933054.jpg'),
                ),
              ),
              Opacity(
                opacity: 0.75,
                child: Container(
                  height: 25,
                  width: 25,
                  decoration: BoxDecoration(
                      color: kPrimaryColor, shape: BoxShape.circle),
                  child: Icon(Icons.play_arrow, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
