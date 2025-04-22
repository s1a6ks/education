import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'gallery_screen.dart';

void main() {
  runApp(const ImageViewerApp());
}

class ImageViewerApp extends StatelessWidget {
  const ImageViewerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Переглядач картинок',
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/animals': (context) => const GalleryScreen(
              title: 'Тварини',
              imagePaths: [
                'assets/animals/animal1.jpg',
                'assets/animals/animal2.jpg',
                'assets/animals/animal3.jpg',
              ],
            ),
        '/nature': (context) => const GalleryScreen(
              title: 'Природа',
              imagePaths: [
                'assets/nature/nature1.jpg',
                'assets/nature/nature2.jpg',
                'assets/nature/nature3.jpg',
              ],
            ),
        '/cities': (context) => const GalleryScreen(
              title: 'Міста',
              imagePaths: [
                'assets/cities/city1.jpg',
                'assets/cities/city2.jpg',
                'assets/cities/city3.jpg',
              ],
            ),
      },
    );
  }
}