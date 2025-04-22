import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Головна')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Кнопка для Тварин
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/animals'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), 
              ),
              child: const Text('Тварини'),
            ),
            const SizedBox(height: 10), 
            // Кнопка для Природи
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/nature'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), 
              ),
              child: const Text('Природа'),
            ),
            const SizedBox(height: 10), 
            // Кнопка для Міст
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/cities'),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 50), 
              ),
              child: const Text('Міста'),
            ),
          ],
        ),
      ),
    );
  }
}
