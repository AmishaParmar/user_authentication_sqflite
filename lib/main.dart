import 'package:flutter/material.dart';
import 'package:user_authentication_sqflite/screens/start_up_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home:  StartUp(),
    );
  }
}