import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/components/button.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/features/authentication/providers/connection_provider.dart';
import 'package:inxpecta/src/screens/home_screen.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:inxpecta/src/utils/next_screen.dart';
import 'package:inxpecta/src/utils/snack_bar.dart';
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
  final TextEditingController _usernameController = TextEditingController();
  late AuthStateProvider authStateProvider;

  bool _isLoading = false;
  final db = FirebaseFirestore.instance;

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
    final authP = context.read<AuthStateProvider>();
    authStateProvider = Provider.of<AuthStateProvider>(context, listen: true);
    final connP = context.read<ConnectionProvider>();

    Future handleSingUp() async {
      String email = _emailController.text.trim();
      String password = _passwordController.text.trim();
      String username = _usernameController.text.trim();

      setState(() {
        _isLoading = true;
      });
      if (connP.hasInternet == false) {
        openSnackBar(context, "No internet :(", MyConstants.primaryColor);
        setState(() {
          _isLoading = false;
        });
      } else if (email.isEmpty || password.isEmpty || username.isEmpty) {
        setState(() {
          _isLoading = false;
        });
        openSnackBar(context, "Fill in your details", Colors.deepOrange);
        setState(() {
          _isLoading = false;
        });
      } else {
        try {
          await authP.signUp(email, password, username);

          setState(() {
            _isLoading = false;
          });
          if (authP.currentUser != null) {
            await db.collection("users").add({
              "name": username,
              "email": authP.currentUser?.email,
              "uid": authP.currentUser?.uid,
              "photoUrl": null
            });

            // Update the authentication state
            context.read<AuthStateProvider>().setAuthState(authP.currentUser);
            if (authStateProvider.currentUser?.email != null) {
              setState(() {
                _isLoading = false;
              });
              handleAfterSignUp();
            }

            // Print user details
          }

          handleAfterSignUp();
        } on FirebaseAuthException catch (e) {
          String errorMessage;
          setState(() {
            _isLoading = false;
          });

          switch (e.code) {
            case 'user-not-found':
              errorMessage = 'User not found. Please check your email.';
              break;
            case 'wrong-password':
              errorMessage = 'Incorrect password. Please try again.';
              break;
            case 'invalid-email':
              errorMessage = 'Incorrect email. Please try again.';

            default:
              errorMessage = 'Incorrect password. Please try again.';
              break;
          }
          openSnackBar(context, errorMessage, Colors.deepOrange);
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          setState(() {
            _isLoading = false;
          });
          openSnackBar(
              context, 'An unexpected error occurred. $e', Colors.deepOrange);
        }
      }
    }

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
              const SizedBox(height: 8.0),
              Stack(children: [
                MyButton(
                  label: "Sign In",
                  onTap: handleSingUp,
                ),
                Visibility(
                  visible: _isLoading,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: MyConstants.secondaryColor,
                    ),
                    height: 76,
                    width: MyConstants.screenWidth(context),
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Colors.amber,
                        strokeWidth: 5,
                      ),
                    ),
                  ),
                )
              ]),
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

  handleAfterSignUp() {
    Future.delayed(const Duration(milliseconds: 200))
        .then((value) => {nextScreen(context, const MyHomePage())});
  }
}
