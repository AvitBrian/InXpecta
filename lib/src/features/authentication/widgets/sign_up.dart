import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/components/button.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:lottie/lottie.dart';

import '../components/textfield.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  children: [
                    const Text("Welcome to", style: TextStyle(fontSize: 20)),
                    const SizedBox(
                      width: 4,
                    ),
                    Text(
                      "InXpecta",
                      style: TextStyle(
                          color: MyConstants.primaryColor, fontSize: 16),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.0),
                child: Row(
                  children: [
                    Text(
                      "Let's Sign You Up!",
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              MyTextField(
                hintText: "Names",
              ),
              const SizedBox(height: 8.0),
              MyTextField(
                hintText: "Username",
              ),
              const SizedBox(height: 8.0),
              MyTextField(
                hintText: "Email",
                obscureText: false,
              ),
              const SizedBox(height: 8.0),
              MyTextField(
                hintText: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 8.0),
              MyTextField(
                hintText: "Phone",
                obscureText: false,
              ),
              const SizedBox(height: 8.0),
              MyButton(
                label: "Sign Up",
                onTap: () {
                  if (!isLoggedIn) {
                    isLoggedIn = true;
                    _controller.reverse(from: 50);
                  } else {
                    isLoggedIn = false;
                  }
                },
              ),
              SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Lottie.asset('assets/animations/form.json',
                         animate: true, fit: BoxFit.fill),
                  )),

            ],
          ),
        ),
      ),
    );
  }
}
