import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  const StartScreen(this.startTest, {super.key});

  final void Function() startTest;

  @override
  Widget build(context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 80),
          const Text(
            'Який ти тип мислення?',
            style: TextStyle(
              color: Color.fromARGB(255, 237, 223, 252),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),
          OutlinedButton.icon(
            onPressed: startTest,
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
            ),
            icon: const Icon(Icons.psychology),
            label: const Text('Розпочати тест'),
          )
        ],
      ),
    );
  }
}