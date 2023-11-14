import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class AuthStateProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isSignedUp = true;
  bool _hasError = false;

  String? _errorCode;
  //instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  User? _currentUser;
  late final String? _userEmail;
  late final String? _userPassword;

  //usercredentials
  String? _email;
  String? _name;
  String? _photoUrl;
  String? _uid;

  //Getters here!
  bool get signedState => _isSignedUp;
  bool get hasError => _hasError;
  bool get isloggedIn => _isLoggedIn;
  User? get currentUser => _currentUser;
  String? get errorCode => _errorCode;
  String? get userEmail => _userEmail;
  String? get userPassword => _userPassword;
  String? get email => _email;
  String? get name => _name;
  String? get photoUrl => _photoUrl;
  String? get uid => _uid;

  AuthStateProvider() {
    // checkAuthState();
  }

  Future checkAuthState() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    _isLoggedIn = s.getBool("signed_in") ?? false;
    notifyListeners();
  }

  Future setAuthState() async {
    _isLoggedIn = true;
    final SharedPreferences s = await SharedPreferences.getInstance();
    s.setBool("signed_in", true);
    notifyListeners();
  }

  // void toggleAuthState(User? user) {
  //   _currentUser = user;
  //   _isLoggedIn = user != null;
  //   notifyListeners();
  // }

  void toggleSigned() {
    _isSignedUp = !_isSignedUp;
    notifyListeners();
  }

  Future<void> signInWithEmailAndPassword(userEmail, userPassword) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: userEmail,
        password: userPassword,
      );

      _currentUser = userCredential.user;
      _email = _currentUser!.email;
      _name = _currentUser!.displayName;
      _photoUrl = _currentUser!.photoURL;
      _uid = _currentUser!.uid;
      setAuthState();
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case "invalid-email":
          _hasError = true;
          _errorCode = e.message;
          break;
        case "INVALID_LOGIN_CREDENTIALS":
          _hasError = true;
          _errorCode = "invalid credentials!";
          break;
        case "user-not-found":
          _hasError = true;
          _errorCode = e.code;
          break;
        case "account-exists-with-different-credentials":
          _errorCode = "Account already Exists";
          _hasError = true;
          notifyListeners();
          break;
        case "null":
          _hasError = true;
          _errorCode = "unexpected Error please try again later";
          notifyListeners();
          break;
        default:
          _errorCode = e.message;
          _hasError = true;
          notifyListeners();
          break;
      }
    }
  }

  Future<void> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      _hasError = true;
      notifyListeners();
    } else {
      try {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        // Once signed in, return the UserCredential
        // UserCredential userCredential =
        //     await _auth.signInWithCredential(credential);
        User userDetails = (await _auth.signInWithCredential(credential)).user!;

        _email = userDetails.email;
        _name = userDetails.displayName;
        _photoUrl = userDetails.photoURL;
        _uid = userDetails.uid;
        _hasError = false;
        setAuthState();
        notifyListeners();
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case "account-exists-with-different-credentials":
            _errorCode = "Account already Exists";
            _hasError = true;
            notifyListeners();
            break;
          case "null":
            _hasError = true;
            _errorCode = "unexpected Error please try again later";
            notifyListeners();
            break;
          default:
            _errorCode = e.message;
            _hasError = true;
            notifyListeners();
            break;
        }
      }
    }
    // print(userCredential.user);
    // toggleAuthState(userCredential.user);
    notifyListeners();
  }

  Future<void> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    if (loginResult.status == LoginStatus.success) {
      // Check if accessToken is not null before accessing its properties
      if (loginResult.accessToken != null) {
        final graphResponse = await http.get(Uri.parse(
            'https://graph.facebook.com/v2.12/me?fields=name,picture.width(50).height(50),first_name,last_name,email&access_token=${loginResult.accessToken!.token}'));
        final profileData = jsonDecode(graphResponse.body);
        final profileName = profileData["name"];
        final profileEmail = profileData["email"];
        final profileId = profileData["id"];
        final profilePicUrl = profileData["picture"]["data"]["url"];

        // Create a credential from the access token
        try {
          final OAuthCredential facebookAuthCredential =
              FacebookAuthProvider.credential(loginResult.accessToken!.token);

          // Once signed in, return the UserCredential
          await _auth.signInWithCredential(facebookAuthCredential);
          _email = profileEmail;
          _name = profileName;
          _photoUrl = profilePicUrl;
          _uid = profileId;
          setAuthState();
          notifyListeners();
        } on FirebaseAuthException catch (e) {
          _hasError = true;
          _errorCode = e.message;
          notifyListeners();
        }
        // toggleAuthState(userCredential.user);
      }
    }
  }

  Future<bool> checkUserExists() async {
    DocumentSnapshot snap =
        await FirebaseFirestore.instance.collection('úsers').doc(_uid).get();
    if (snap.exists) {
      return true;
    }
    return false;
  }

  Future getUserDataFromFireStore() async {
    await FirebaseFirestore.instance
        .collection("users")
        .doc(uid)
        .get()
        .then((DocumentSnapshot snapshot) => {
              _uid = snapshot["uid"],
              _name = snapshot["name"],
              _email = snapshot["email"],
              _photoUrl = snapshot["photoUrl"]
            });
  }

  Future saveDataToFireStore() async {
    final DocumentReference r =
        FirebaseFirestore.instance.collection("users").doc(uid);
    await r.set({
      "name": _name,
      "email": _email,
      "uid": _uid,
      "photoUrl": _photoUrl,
    });
  }

  Future saveDataToSharedPreferences() async {
    final SharedPreferences s = await SharedPreferences.getInstance();
    await s.setString("name", _name!);
    await s.setString("email", _email!);
    await s.setString("uid", _uid!);
    // await s.setString("photoURL", _photoUrl);
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();
      await _facebookAuth.logOut();
      _isLoggedIn = false;
      notifyListeners();
      final SharedPreferences s = await SharedPreferences.getInstance();
      s.setBool("signed_in", false);
      s.clear();
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}
