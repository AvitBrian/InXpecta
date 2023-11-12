import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthStateProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isSignedUp = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _currentUser;
  late final String? _userEmail;
  late final String? _userPassword;

  //Getters here!
  bool get authState => _isLoggedIn;
  bool get signedState => _isSignedUp;
  User? get currentUser => _currentUser;
  String? get userEmail => _userEmail;
  String? get userPassword => _userPassword;

  void toggleAuthState(User? user) {
    _currentUser = user;
    _isLoggedIn = user != null;
    notifyListeners();
  }

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

      // _currentUser = userCredential.user;
      toggleAuthState(userCredential.user);
      notifyListeners();
    } catch (e) {
      print('Error signing in: $e');
      // Handle the error, show a snackbar, or display an error message
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
      _currentUser = null;
      _isLoggedIn = false;
      notifyListeners();
    } catch (e) {
      print('Error signing out: $e');
      // Handle the error, show a snackbar, or display an error message
    }
  }
}
