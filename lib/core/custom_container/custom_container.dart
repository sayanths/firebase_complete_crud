import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double height;
  final double width;
  final Widget? child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Decoration? decoration;
  final Color? color;
  const CustomContainer({
    super.key,
    required this.height,
    required this.width,
    this.child,
    this.padding,
    this.margin,
    this.decoration,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      padding: padding,
      margin: margin,
      height: height,
      width: width,
      decoration: decoration,
      child: child,
    );
  }
}

class MediaquerySize {
  static double height(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return height;
  }

  static double width(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width;
  }
}
