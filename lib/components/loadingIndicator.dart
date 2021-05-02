import 'package:flutter/material.dart';
import '../constants.dart';

class LoadingIndicator extends StatelessWidget {
  const LoadingIndicator({
    Key key,
    @required this.isLoading,
    this.radius = 36,
  }) : super(key: key);

  final bool isLoading;
  final double radius;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isLoading,
      child: Center(
        child: Container(
          height: radius,
          width: radius,
          child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(kPrimaryColor),
              backgroundColor: kPrimaryColor.withOpacity(0)),
        ),
      ),
    );
  }
}
