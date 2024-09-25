import 'package:flutter/material.dart';

class GradientDivider extends StatelessWidget {
  final double width;
  final double height;
  final bool reverse;
  final Color startColor;
  final Color endColor;

  const GradientDivider({
    Key? key,
    this.width = double.infinity,
    this.height = 1.0,
    this.reverse = false,
    this.startColor = Colors.transparent,
    this.endColor = Colors.black26,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: reverse
              ? [endColor, startColor]
              : [startColor, endColor],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
    );
  }
}
