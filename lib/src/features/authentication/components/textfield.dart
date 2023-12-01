import 'package:flutter/material.dart';
import 'package:inxpecta/src/utils/constants.dart';

class MyTextField extends StatelessWidget {
  final String? hintText;
  final TextEditingController? controller;
  final bool obscureText;
  final int? height;

  MyTextField({
    this.hintText,
    this.controller,
    this.obscureText = false,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    double width = MyConstants.screenWidth(context);
    double height = MyConstants.screenHeight(context);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.005),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500]),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
        ),
        controller: controller,
        obscureText: obscureText,
      ),
    );
  }
}
