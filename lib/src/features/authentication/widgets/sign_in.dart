import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/components/button.dart';
import 'package:inxpecta/src/features/authentication/components/container.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:lottie/lottie.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/textfield.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key});

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm>
    with SingleTickerProviderStateMixin {
  //variables
  bool isLoggedIn = false;

  //controllers here!
  late final AnimationController _controller;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    _controller.dispose();
  }

Future<void> signInWithEmailAndPassword() async {
  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  print('Email: $email');
  print('Password: $password');
  try {
    UserCredential userCredential = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    
    print('User signed in: ${userCredential.user?.uid}');
    // Navigate to the next screen or perform any other action on successful sign-in
  } catch (e) {
    print('Error signing in: $e');
    // Handle the error, show a snackbar, or display an error message
  }
}


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
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
            controller: emailController,
          ),
          const SizedBox(height: 16.0),
          MyTextField(
            hintText: "Password",
            controller: passwordController,
            obscureText: true,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton(
                  onPressed: () {},
                  child: const Text(
                    "Forgot Password?",
                  )),
            ],
          ),
          MyButton(
            label: "Sign In",
            onTap: () {
              signInWithEmailAndPassword();
            },
          ),
          const SizedBox(
            height: 16,
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
          const SizedBox(
            height: 16,
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
                width: 8,
              ),
              MyContainer(
                image: "assets/images/facebook.png",
                height: 50,
                width: 50,
                color: Colors.white,
              )
            ],
          ),
        ],
      ),
    );
  }
}
