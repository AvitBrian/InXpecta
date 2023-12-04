import 'package:flutter/material.dart';
import 'package:inxpecta/src/utils/constants.dart';

class MyButton extends StatelessWidget {
  final String? label;
  final double? width;
  final double? height;
  final BorderRadius? roundness;
  final Color? color;
  final Color? backgroundColor;
  final Function() onTap;

  const MyButton(
      {super.key,
      this.label,
      this.backgroundColor,
      this.width,
      this.height,
      this.color,
      required this.onTap,
      this.roundness});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: backgroundColor ?? MyConstants.primaryColor,
              borderRadius: roundness ?? BorderRadius.circular(8.0)),
          child: Center(
            child: Text(
              label!,
              style: TextStyle(
                  color: color ?? Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )),
    );
  }
}
