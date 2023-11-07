import 'package:flutter/foundation.dart';

class AuthStateProvider extends ChangeNotifier {
  bool _authState = true;

  bool get authState => _authState;

  void toggleAuthState() {
    _authState = !_authState;
    notifyListeners();
  }
}
