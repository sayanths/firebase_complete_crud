import 'package:firebase_todo/core/google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final Color color;
  final double width;
  final double height;

  const PlatformButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.color,
    this.width = 150.0, // Default width
    this.height = 40.0, // Default height
  });

  @override
  Widget build(BuildContext context) {
    if (Theme.of(context).platform == TargetPlatform.iOS) {
      return CupertinoButton(
        color: color,
        onPressed: onPressed,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Text(
            text,
            style: K2DFonts.bold(fontSize: 18),
          ),
        ),
      );
    } else {
      return ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(color),
        ),
        onPressed: onPressed,
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          child: Text(
            text,
            style: K2DFonts.bold(fontSize: 18),
          ),
        ),
      );
    }
  }
}
