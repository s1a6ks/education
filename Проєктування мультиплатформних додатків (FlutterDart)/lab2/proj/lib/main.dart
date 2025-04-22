// main.dart
import 'package:flutter/material.dart';
import 'package:proj/gradient_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: GradientContainer(
          Color(0xFF232526),
          Color(0xFF414345),
        ),
      ),
    );
  }
}