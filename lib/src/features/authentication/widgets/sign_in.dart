import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/components/button.dart';
import 'package:inxpecta/src/features/authentication/components/container.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:lottie/lottie.dart';

import '../components/textfield.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    double width = MyConstants.screenWidth(context);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: SizedBox(
        height: MyConstants.screenHeight(context),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16.0),
              SizedBox(
                  height: 200,
                  child: Lottie.asset('assets/animations/lock3.json',
                      controller: _controller, onLoaded: (composition) {
                    _controller.duration = composition.duration;
                  }, height: 100, animate: true, fit: BoxFit.fitWidth)),
              const SizedBox(
                height: 8,
              ),
              Text(
                "Welcome Back, you've been missed!",
                style: TextStyle(color: MyConstants.textColor),
              ),
              const SizedBox(
                height: 8,
              ),
              MyTextField(
                hintText: "Email",
              ),
              const SizedBox(height: 16.0),
              MyTextField(
                hintText: "Password",
                obscureText: true,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {},
                      child: Text(
                        "Forgot Password?",
                      )),
                ],
              ),
              MyButton(
                label: "Sign In",
                onTap: () {
                  if (!isLoggedIn) {
                    isLoggedIn = true;
                    _controller.forward();
                  } else {
                    isLoggedIn = false;
                  }
                },
              ),
              Row(
                children: [
                  Expanded(
                    child: Divider(
                      thickness: .5,
                      color: MyConstants.textColor,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "or Sign in with",
                      style: TextStyle(color: MyConstants.textColor),
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      thickness: 0.5,
                      color: MyConstants.textColor,
                    ),
                  )
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyContainer(
                    image: "assets/images/google.png",
                    height: 50,
                    width: 50,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 4,
                  ),
                  MyContainer(
                    image: "assets/images/facebook.png",
                    height: 50,
                    width: 50,
                    color: Colors.white,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
