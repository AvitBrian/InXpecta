import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/auth_screen.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, this.title});

  final String? title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
   late AuthStateProvider authStateProvider;
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
         authStateProvider =
        Provider.of<AuthStateProvider>(context, listen: true);
        
    return Scaffold(
      body: SizedBox.expand(
        child: Center(
          child: authStateProvider.authState
              ? const Text("Home Screen")
              : const AuthScreen(),
        ),
      ),
    );
  }
}
