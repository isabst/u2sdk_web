import 'package:flutter/material.dart';
import 'screens/password_generator_screen.dart';
import 'package:u2stk_web/router.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => TitleProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Consumer<TitleProvider>(
      builder: (context, titleProvider, child) {
        return MaterialApp(
          title: titleProvider.title,
          onGenerateTitle: (context) => titleProvider.title,
          theme: ThemeData(
            useMaterial3: true,
          ),
          home: const PasswordGeneratorScreen(),
        );
      },
    );
  }
}
