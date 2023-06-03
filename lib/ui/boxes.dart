import 'package:flutter/material.dart';

class CustomBox extends StatelessWidget {
  const CustomBox(
      {super.key,
      this.height,
      required this.width,
      required this.color,
      required this.text});
  final double? height;
  final double width;
  final Color color;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
      child: Center(
          child: Text(
        text,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      )),
    );
  }
}
