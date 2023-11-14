import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/components/button.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/screens/auth_screen.dart';
import 'package:inxpecta/src/utils/next_screen.dart';
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
    return Scaffold(
      body: SafeArea(
        child: SizedBox.expand(
          child: Center(
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      height: 50,
                      width: 50,
                      child: Image.network(
                        "${authStateProvider.photoUrl}",
                        height: 50,
                        width: 50,
                      ),
                    ),
                    Text(
                      "Welcome, ${authStateProvider.name}",
                    ),
                  ],
                ),
                MyButton(
                  onTap: () {
                    context.read<AuthStateProvider>().signOut();
                    nextScreenReplacement(context, const AuthScreen());
                  },
                  label: "Sign Out",
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
