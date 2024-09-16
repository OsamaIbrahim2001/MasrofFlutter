import 'package:flutter/material.dart';
import 'package:my_project/Services/auth_service.dart';
import 'package:my_project/Services/session_manager.dart';
import 'package:provider/provider.dart';
import 'HomePage.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final AuthService _authService = AuthService();
  bool _isAuthenticating = false;
  bool _authenticated = false;

  @override
  void initState() {
    super.initState();
    _authenticate();
  }

  Future<void> _authenticate() async {
    setState(() {
      _isAuthenticating = true;
    });

    bool authenticated = await _authService.authenticate();
    setState(() {
      _isAuthenticating = false;
      _authenticated = authenticated;
    });

    if (_authenticated) {
      // ignore: use_build_context_synchronously
      Provider.of<SessionManager>(context, listen: false)
          .startSessionTimer(context);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const HomePage()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Authentication Required')),
      body: Center(
        child: _isAuthenticating
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: _authenticate,
                child: const Text('Authenticate'),
              ),
      ),
    );
  }
}
