import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

Future<UserCredential> signInWithFacebook() async {
  // Trigger the sign-in flow
  final LoginResult loginResult = await FacebookAuth.instance.login();

  if (loginResult != null) {
    // Check if accessToken is not null before accessing its properties
    if (loginResult.accessToken != null) {
      // Create a credential from the access token
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken!.token);

      // Once signed in, return the UserCredential
      return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    } else {
      // Handle the case where accessToken is null
      throw FirebaseAuthException(
        code: 'facebook-login-error',
        message: 'Facebook login failed: Access token is null.',
      );
    }
  } else {
    // Handle the case where loginResult is null
    throw FirebaseAuthException(
      code: 'facebook-login-error',
      message: 'Facebook login failed: Login result is null.',
    );
  }
}
