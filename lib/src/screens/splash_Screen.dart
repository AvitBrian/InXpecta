import 'dart:async';

import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/screens/auth_screen.dart';
import 'package:inxpecta/src/screens/home_screen.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:inxpecta/src/utils/next_screen.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final authP = context.read<AuthStateProvider>();
    Timer(const Duration(seconds: 3), () {
      print("someone is logged in?  ${authP.isloggedIn}");
      authP.isloggedIn
          ? nextScreen(context, const MyHomePage())
          : nextScreen(context, const AuthScreen());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyConstants.primaryColor,
      body: const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
