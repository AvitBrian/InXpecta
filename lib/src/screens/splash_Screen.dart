import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/screens/auth_screen.dart';
import 'package:inxpecta/src/screens/home_screen.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:inxpecta/src/utils/next_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late AuthStateProvider authStateProvider;

  @override
  void initState() {
    super.initState();

    // Delay the navigation to the next frame

    Future.delayed(Duration.zero, () {
      authStateProvider =
          Provider.of<AuthStateProvider>(context, listen: false);

      checkAuthState();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  void checkAuthState() async {
    if (context.mounted) {
      await authStateProvider.checkAuthState();

      if (authStateProvider.isloggedIn) {
        print(authStateProvider.isloggedIn);
        // User is already signed in
        nextScreenReplacement(context, const MyHomePage());
      } else {
        nextScreenReplacement(context, AuthScreen());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(children: [
        LinearProgressIndicator(),
        Expanded(
            child: Column(
          children: [
            Text(
              "InXpecta",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: MyConstants.primaryColor),
            ),
            Expanded(
              child: SizedBox(
                  height: MyConstants.screenHeight(context) * .5,
                  child: Lottie.asset('assets/animations/Animation4.json',
                      height: 200, animate: true, fit: BoxFit.fitWidth)),
            ),
          ],
        ))
      ])),
    );
  }
}
