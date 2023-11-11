import 'package:flutter/foundation.dart';

class AuthStateProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isSignedUp = true;

  bool get authState => _isLoggedIn;
  bool get signedState => _isSignedUp;

  void toggleAuthState() {
    _isLoggedIn = !_isLoggedIn;
    notifyListeners();
  }

  void toggleSigned() {
    _isSignedUp = !_isSignedUp;
    notifyListeners();
  }
}
