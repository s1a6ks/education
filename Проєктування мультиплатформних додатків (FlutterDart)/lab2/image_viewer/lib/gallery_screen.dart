import 'package:flutter/material.dart';

class GalleryScreen extends StatefulWidget {
  final String title;
  final List<String> imagePaths;

  const GalleryScreen({
    super.key,
    required this.title,
    required this.imagePaths,
  });

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  int currentIndex = 0;

  void nextImage() {
    setState(() {
      currentIndex = (currentIndex + 1) % widget.imagePaths.length;
    });
  }

  void previousImage() {
    setState(() {
      currentIndex =
          (currentIndex - 1 + widget.imagePaths.length) % widget.imagePaths.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            widget.imagePaths[currentIndex],
            width: 400,  
            height: 300, 
            fit: BoxFit.contain, 
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: previousImage,
                icon: const Icon(Icons.arrow_back),
              ),
              IconButton(
                onPressed: nextImage,
                icon: const Icon(Icons.arrow_forward),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('На головну'),
          ),
        ],
      ),
    );
  }
}
