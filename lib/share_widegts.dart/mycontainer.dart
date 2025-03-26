import 'package:flutter/material.dart';

class MyContainer extends StatelessWidget {
  final double width, height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final Widget child;
  final double radius;

  const MyContainer(
      {super.key,
      this.width = 150,
      this.height = 100,
      this.padding,
      this.margin,
      this.color,
      required this.child,
      this.radius = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        gradient: line1,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: child,
    );
  }
}

const line1 = LinearGradient(colors: [
  Color.fromARGB(255, 239, 131, 212),
  Color.fromARGB(255, 74, 20, 112),
  Color.fromARGB(255, 36, 1, 29)
]);
