import 'package:flutter/material.dart';
import 'package:inxpecta/src/utils/constants.dart';

class MyContainer extends StatelessWidget {
  final String? image;
  final double? height;
  final double? width;
  final Color color;
  const MyContainer(
      {super.key, this.image, this.width, this.height, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color, width: 2),
          color: MyConstants.secondaryColor),
      child: Image.asset(
        image!,
        height: height,
        width: width,
      ),
    );
  }
}
