import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/components/button.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

import '../components/textfield.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _namesController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> _signUpWithEmailAndPassword() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String username = _usernameController.text.trim();

    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // You can handle the newly created user here (e.g., save additional data to Firestore)
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(username);
        await user.reload();
        user = _auth.currentUser;
      }
      Future.delayed(Duration.zero, () {
        context.read<AuthStateProvider>().toggleAuthState(userCredential.user);
      });

      // print('User signed up: ${user?.uid}');
    } catch (e) {
      print('Error signing up: $e');
      // Handle the error, show a snackbar, or display an error message
    }
  }

  @override
  Widget build(BuildContext context) {
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
                controller: _namesController,
              ),
              const SizedBox(height: 8.0),
              MyTextField(
                hintText: "Username",
                controller: _usernameController,
              ),
              const SizedBox(height: 8.0),
              MyTextField(
                hintText: "Email",
                obscureText: false,
                controller: _emailController,
              ),
              const SizedBox(height: 8.0),
              MyTextField(
                hintText: "Password",
                obscureText: true,
                controller: _passwordController,
              ),
              const SizedBox(height: 8.0),
              MyTextField(
                hintText: "Phone",
                obscureText: false,
                controller: _phoneController,
              ),
              const SizedBox(height: 8.0),
              MyButton(
                label: "Sign Up",
                onTap: _signUpWithEmailAndPassword,
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
