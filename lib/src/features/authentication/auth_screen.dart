import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/features/authentication/widgets/sign_in.dart';
// import 'package:inxpecta/src/features/authentication/widgets/sign_in.dart';
import 'package:inxpecta/src/features/authentication/widgets/sign_up.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:provider/provider.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authStateProvider = Provider.of<AuthStateProvider>(context);

    return Scaffold(
      backgroundColor: MyConstants.backgroundColor,
      body: SafeArea(
        child: SizedBox(
          height: MyConstants.screenHeight(context),
          width: MyConstants.screenWidth(context),
          child: Column(children: [
            Expanded(
                flex: 10,
                child: SizedBox(
                    width: MyConstants.screenWidth(context),
                    child: SingleChildScrollView(
                      child: authStateProvider.signedState
                          ? const SignInForm()
                          : const SignUpForm(),
                    ))),
            Expanded(
              child: Container(
                alignment: Alignment.bottomCenter,
                width: MyConstants.screenWidth(context),
                child: authStateProvider.signedState
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Not a Member?"),
                          TextButton(
                            onPressed: authStateProvider.toggleSigned,
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: const Text("Register"),
                          )
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already a member?"),
                          TextButton(
                            onPressed: authStateProvider.toggleSigned,
                            style: ButtonStyle(
                              overlayColor:
                                  MaterialStateProperty.all(Colors.transparent),
                            ),
                            child: const Text("Log in!"),
                          )
                        ],
                      ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
