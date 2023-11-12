import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/auth_screen.dart';
import 'package:inxpecta/src/features/authentication/components/button.dart';
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
    authStateProvider = Provider.of<AuthStateProvider>(context, listen: true);
    User? user = authStateProvider.currentUser;

    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Center(
            child: authStateProvider.authState
                ? Column(
                    children: [
                      Text("Welcome, ${user?.displayName}"),
                      MyButton(
                        onTap: () {
                          context.read<AuthStateProvider>().signOut();
                          print(authStateProvider.authState);
                        },
                        label: "Sign Out",
                      )
                    ],
                  )
                : const AuthScreen(),
          ),
        ),
      ),
    );
  }
}
