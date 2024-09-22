import 'package:flutter/material.dart';
import 'package:my_project/Providers/masrof_provider.dart';
import 'package:my_project/UI/HomePage.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (context) =>
                MasrofProvider()), // For managing Masrof entries
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
      home: HomePage(), // Starts with authentication screen
    );
  }
}
