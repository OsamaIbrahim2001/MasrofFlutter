import 'dart:async';
import 'package:flutter/material.dart';
import 'package:my_project/UI/AuthScreen.dart';
import 'auth_service.dart';

class SessionManager extends ChangeNotifier {
  static const int sessionTimeoutInSeconds = 60; // 1 minute for demo
  Timer? _sessionTimer;
  bool _isAuthenticated = true;

  final AuthService _authService = AuthService();

  bool get isAuthenticated => _isAuthenticated;

  void startSessionTimer(BuildContext context) {
    _resetSessionTimer(context);
  }

  void resetSessionTimer(BuildContext context) {
    _resetSessionTimer(context);
  }

  void cancelSessionTimer() {
    _sessionTimer?.cancel();
  }

  void _resetSessionTimer(BuildContext context) {
    _sessionTimer?.cancel();
    _sessionTimer =
        Timer(const Duration(seconds: sessionTimeoutInSeconds), () async {
      _isAuthenticated = false;
      notifyListeners();
      bool authenticated = await _authService.authenticate();
      if (!authenticated) {
        // ignore: use_build_context_synchronously
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => const AuthScreen()));
      }
    });
  }
}
