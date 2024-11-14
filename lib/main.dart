import 'package:flutter/material.dart';
import 'screens/password_generator_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'u2stk',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const PasswordGeneratorScreen(),
    );
  }
}
