import 'package:flutter/foundation.dart';

class AuthStateProvider extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get authState => _isLoggedIn;

  void toggleAuthState() {
    _isLoggedIn = !_isLoggedIn;
    notifyListeners();
  }
}
