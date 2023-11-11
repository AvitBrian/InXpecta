import 'package:flutter/material.dart';

class MyConstants {
  // Screen width
  static double screenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  // Screen height
  static double screenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  // Primary color
  static Color primaryColor = Colors.amberAccent;

  // Secondary color (teal)
  static Color secondaryColor = Colors.white;

  // Background color
  static Color backgroundColor = Colors.grey.shade500;
  // text color
  static Color textColor = Colors.grey.shade600;
}
