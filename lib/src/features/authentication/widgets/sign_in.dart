import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:inxpecta/src/features/authentication/components/button.dart';
import 'package:inxpecta/src/features/authentication/components/container.dart';
import 'package:inxpecta/src/features/authentication/providers/auth_provider.dart';
import 'package:inxpecta/src/features/authentication/providers/connection_provider.dart';
import 'package:inxpecta/src/screens/home_screen.dart';
import 'package:inxpecta/src/utils/constants.dart';
import 'package:inxpecta/src/utils/next_screen.dart';
import 'package:inxpecta/src/utils/snack_bar.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

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
  bool _isLoadingGoogle = false;
  bool _isLoadingFacebook = false;
  bool _isLoading = false;

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

  Future<void> signInWithEmailAndPassword(BuildContext context) async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      print('User signed in: ${userCredential.user?.uid}');
      // logged in logic
      Future.delayed(Duration.zero, () {
        context.read<AuthStateProvider>().setAuthState();
      });
    } catch (e) {
      print('Error signing in: $e');
      // Handle the error, show a snackbar, or display an error message
    }
  }

  @override
  Widget build(BuildContext context) {
    final authP = context.read<AuthStateProvider>();
    final connP = context.read<ConnectionProvider>();

    Future handleGoogleSignIn() async {
      setState(() {
        _isLoadingGoogle = true;
      });
      if (connP.hasInternet == true) {
        await authP.signInWithGoogle().then((value) {
          if (authP.hasError) {
            setState(() {
              _isLoadingGoogle = false;
            });
            openSnackBar(context, authP.errorCode, Colors.deepOrange);
          } else {
            authP.checkUserExists().then((value) async {
              if (value == false) {
                authP.saveDataToFireStore().then((value) => authP
                        .saveDataToSharedPreferences()
                        .then((value) => authP.setAuthState())
                        .then((value) {
                      _isLoadingGoogle = false;
                      handleAfterLogin();
                    }));
              } else {
                authP
                    .getUserDataFromFireStore()
                    .then((value) => authP.setAuthState().then((value) {
                          setState(() {
                            _isLoadingGoogle = false;
                          });
                          handleAfterLogin();
                        }));
              }
            });
          }
        });
      } else {
        setState(() {
          _isLoading = false;
        });
        openSnackBar(context, "No internet :(", MyConstants.primaryColor);
      }
    }

    Future handleEmailAndPasswordSignIn() async {
      if (connP.hasInternet == false) {
        openSnackBar(context, "No internet :(", MyConstants.primaryColor);
      } else {
        await authP
            .signInWithEmailAndPassword(
                emailController.text.trim(), passwordController.text.trim())
            .then((value) {
          if (authP.hasError) {
            openSnackBar(context, authP.errorCode, Colors.deepOrange);
          } else {
            setState(() {
              _isLoading = false;
            });
            handleAfterLogin();
          }
        });
      }
    }

    Future handleFaceBookSignIn() async {
      setState(() {
        _isLoadingFacebook = true;
      });
      if (connP.hasInternet == false) {
        openSnackBar(context, "No internet :(", MyConstants.primaryColor);
        setState(() {
          _isLoadingFacebook = false;
        });
      } else {
        await authP.signInWithFacebook().then((value) {
          if (authP.hasError) {
            setState(() {
              _isLoadingFacebook = false;
            });
            openSnackBar(context, authP.errorCode, Colors.deepOrange);
          } else {
            authP.checkUserExists().then((value) async {
              if (value == false) {
                authP.saveDataToFireStore().then((value) => authP
                        .saveDataToSharedPreferences()
                        .then((value) => authP.setAuthState())
                        .then((value) {
                      setState(() {
                        _isLoadingFacebook = false;
                      });
                      handleAfterLogin();
                    }));
              } else {
                authP
                    .getUserDataFromFireStore()
                    .then((value) => authP.setAuthState().then((value) {
                          setState(() {
                            _isLoading = false;
                          });
                          handleAfterLogin();
                        }));
              }
            });
          }
        });
      }
    }

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
                _controller.forward();
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
            onTap: handleEmailAndPasswordSignIn,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      handleGoogleSignIn();
                    },
                    child: const MyContainer(
                      image: "assets/images/google.png",
                      height: 50,
                      width: 50,
                      color: Colors.white,
                    ),
                  ),
                  // Dark background
                  Visibility(
                    visible: _isLoadingGoogle,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      height: 70,
                      width: 70,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                          strokeWidth: 5,
                        ),
                      ),
                    ),
                  )
                  // Loading circle
                ],
              ),
              const SizedBox(
                width: 8,
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      handleFaceBookSignIn();
                    },
                    child: const MyContainer(
                      image: "assets/images/facebook.png",
                      height: 50,
                      width: 50,
                      color: Colors.white,
                    ),
                  ),
                  // Dark background
                  Visibility(
                    visible: _isLoadingFacebook,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      height: 70,
                      width: 70,
                      child: Center(
                        child: CircularProgressIndicator(
                          color: Colors.amber,
                          strokeWidth: 5,
                        ),
                      ),
                    ),
                  )
                  // Loading circle
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  handleAfterLogin() {
    Future.delayed(const Duration(milliseconds: 1000))
        .then((value) => {nextScreen(context, const MyHomePage())});
  }
}
