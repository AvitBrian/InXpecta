import 'package:flutter/material.dart';
import 'package:inxpecta/features/authentication/widgets/sign_in.dart';
import 'package:inxpecta/features/authentication/widgets/sign_up.dart';
import 'package:provider/provider.dart';
import 'package:inxpecta/features/authentication/providers/auth_provider.dart';

class AuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authStateProvider = Provider.of<AuthStateProvider>(context);

    void toggleAuthState() {
      authStateProvider.toggleAuthState();
    }

    return Scaffold(
      body: authStateProvider.authState ? const SignUpForm() : const SignInForm(),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleAuthState,
        child: const Icon(Icons.swap_horiz),
      ),
    );
  }
}
