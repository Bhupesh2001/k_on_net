import 'package:flutter/material.dart';
import 'package:k_on_net/model/chat_message.dart';
import '../../../../constants.dart';

class AudioMessage extends StatefulWidget {
  final ChatMessage message;

  const AudioMessage({Key key, this.message}) : super(key: key);
  @override
  _AudioMessageState createState() => _AudioMessageState(message);
}

class _AudioMessageState extends State<AudioMessage>
    with TickerProviderStateMixin {
  final ChatMessage message;
  AnimationController controller;
  _AudioMessageState(this.message);

  bool isPlaying = false;
  double currentPlayingTime = 0; // initially time is at 0 sec
  @override
  Widget build(BuildContext context) {
    int lengthOfAudio = int.parse(
        this.message.text); // time is sent as string, thus converted to int
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width * 0.40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: kPrimaryColor.withOpacity(this.message.isSender ? 0.8 : 0.1),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20 * 0.75, vertical: 20 / 8),
      child: Row(
        children: [
          InkWell(
              child: Icon(
                isPlaying ? Icons.pause : Icons.play_arrow,
                size: 18,
                color: message.isSender ? Colors.white : kPrimaryColor,
              ),
              onTap: () {
                setState(() {
                  isPlaying = !isPlaying;
                });
                print('$isPlaying\n');
                if (isPlaying) {
                  controller = AnimationController(
                      vsync: this,
                      duration: Duration(seconds: lengthOfAudio),
                      lowerBound: currentPlayingTime,
                      upperBound: lengthOfAudio.toDouble());
                  controller.forward();
                  controller.addListener(() {
                    setState(() {
                      currentPlayingTime = controller.value;
                      if (controller.isCompleted) {
                        setState(() {
                          currentPlayingTime = 0;
                          isPlaying = false;
                        });
                      }
                    });
                  });
                } else
                  controller.dispose();
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6.0),
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  thumbColor: kPrimaryColor,
                  thumbShape: RoundSliderThumbShape(enabledThumbRadius: 4),
                  overlayShape: RoundSliderOverlayShape(overlayRadius: 0),
                ),
                child: Slider.adaptive(
                  activeColor: kPrimaryColor,
                  inactiveColor: Colors.grey.withOpacity(0.3),
                  value: currentPlayingTime,
                  min: 0,
                  max: lengthOfAudio.toDouble(),
                  onChanged: (double newRating) {
                    setState(() {
                      print("new = $newRating");
                      currentPlayingTime = newRating;
                    });
                  },
                ),
              ),
            ),
          ),
          Text(
            (lengthOfAudio ~/ 60).toString() +
                ":" +
                (lengthOfAudio % 60).toString().padLeft(2, '0'),
            style: TextStyle(
                fontSize: 10,
                color: message.isSender ? Colors.white : kPrimaryColor),
          )
        ],
      ),
    );
  }
}
