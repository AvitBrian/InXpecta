import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/features/authentication/widgets/sign_in.dart';
import 'package:inxpecta/src/features/authentication/widgets/sign_up.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    final authStateProvider = Provider.of<AuthStateProvider>(context);

    void toggleAuthState() {
      authStateProvider.toggleAuthState();
    }

    return Scaffold(
      backgroundColor: MyConstants.backgroundColor,
      body: SafeArea(
        child: authStateProvider.authState
            ? const SignUpForm()
            : const SignInForm(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleAuthState,
        child: const Icon(Icons.swap_horiz),
      ),
    );
  }
}
