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
  bool _isLoginSuccessfull = false;
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

  @override
  Widget build(BuildContext context) {
    final authP = context.read<AuthStateProvider>();
    final connP = context.read<ConnectionProvider>();

    Future handleGoogleSignIn() async {
      setState(() {
        _isLoadingGoogle = true;
      });
      if (connP.hasInternet == false) {
        setState(() {
          _isLoadingGoogle = false;
        });
      }
      if (connP.hasInternet == true) {
        setState(() {
          _isLoginSuccessfull = true;
        });
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
                        .then((value) => authP.setAuthState(authP.currentUser))
                        .then((value) {
                      setState(() {
                        _isLoadingGoogle = false;
                      });
                      handleAfterLogin();
                    }));
              } else {
                authP.getUserDataFromFireStore().then((value) =>
                    authP.setAuthState(authP.currentUser).then((value) {
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
          _isLoadingGoogle = false;
        });
        openSnackBar(context, "No internet :(", MyConstants.primaryColor);
      }
    }

    Future handleEmailAndPasswordSignIn() async {
      setState(() {
        _isLoading = true;
      });
      String email = emailController.value.text.trim();
      String password = passwordController.value.text.trim();
      if (connP.hasInternet == false) {
        openSnackBar(context, "No internet :(", MyConstants.primaryColor);
        setState(() {
          _isLoading = false;
        });
      } else if (email.isEmpty || password.isEmpty) {
        openSnackBar(context, "Fill in your details", Colors.deepOrange);
        setState(() {
          _isLoading = false;
        });
      } else {
        try {
          print(email);
          await authP.signInWithEmailAndPassword(email, password);
          setState(() {
            _isLoading = false;
          });
          handleAfterLogin();
        } on FirebaseAuthException catch (e) {
          setState(() {
            _isLoading = false;
          });

          String errorMessage;

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
          setState(() {
            _isLoading = false;
          });
          openSnackBar(context, errorMessage, Colors.deepOrange);
        } catch (e) {
          setState(() {
            _isLoading = false;
          });
          openSnackBar(
              context, 'An unexpected error occurred. $e', Colors.deepOrange);
        }
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
                        .then((value) => authP.setAuthState(authP.currentUser))
                        .then((value) {
                      setState(() {
                        _isLoadingFacebook = false;
                      });
                      handleAfterLogin();
                    }));
              } else {
                authP.getUserDataFromFireStore().then((value) =>
                    authP.setAuthState(authP.currentUser).then((value) {
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
                if (_isLoginSuccessfull) {
                  _controller.forward();
                }
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
          Stack(children: [
            MyButton(
              label: "Sign In",
              onTap: handleEmailAndPasswordSignIn,
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
                      child: const Center(
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
                      child: const Center(
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
        .then((value) => {nextScreenReplacement(context, const MyHomePage())});
  }
}
