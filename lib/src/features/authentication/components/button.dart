import 'package:flutter/material.dart';
import 'package:inxpecta/src/utils/constants.dart';

class MyButton extends StatelessWidget {
  final String? label;
  final double? width;
  final double? height;
  final Function() onTap;

  const MyButton(
      {super.key, this.label, this.width, this.height, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          height: height,
          width: width,
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: MyConstants.primaryColor,
              borderRadius: BorderRadius.circular(8.0)),
          child: Center(
            child: Text(
              label!,
              style: const TextStyle(
                  color: Colors.black54,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
          )),
    );
  }
}
