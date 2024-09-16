import 'package:flutter/material.dart';
import 'package:my_project/Providers/masrof_provider.dart';
import 'package:my_project/Services/session_manager.dart';
import 'package:provider/provider.dart';
import 'UI/AuthScreen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                MasrofProvider()), // For managing Masrof entries
        ChangeNotifierProvider(
            create: (context) =>
                SessionManager()), // For managing session timeout
      ],
      child: const MasrofApp(),
    ),
  );
}

class MasrofApp extends StatelessWidget {
  const MasrofApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Masrof Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthScreen(), // Starts with authentication screen
    );
  }
}
