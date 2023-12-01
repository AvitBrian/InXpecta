import 'package:flutter/material.dart';

class MyConstants {
  // Screen width
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // Screen height
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Primary color
  static Color primaryColor = const Color(0xffe9d4a2);

  // Secondary color (teal)
  static Color secondaryColor = const Color(0xff543d07);

  // Background color
  static Color backgroundColor = Colors.grey.shade500;
  static Color navColor = Colors.grey.shade200;
  // text color
  static Color textColor = Colors.grey.shade600;
}
