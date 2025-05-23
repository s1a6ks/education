import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter (для Material Design)
import 'package:google_fonts/google_fonts.dart'; // Імпорт пакета для використання шрифтів Google
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Імпорт пакета Riverpod для управління станом

import 'package:meals/screens/tabs.dart'; // Імпорт файлу, що містить віджет головного екрану з вкладками

// Визначення головної теми оформлення застосунку
final theme = ThemeData(
  useMaterial3: true, // Увімкнення Material Design 3
  colorScheme: ColorScheme.fromSeed(
    // Створення колірної схеми на основі заданого кольору
    brightness: Brightness.dark, // Встановлення темної колірної схеми
    seedColor: const Color.fromARGB(
      255,
      131,
      57,
      0,
    ), // Колір-основа для генерації палітри
  ),
  textTheme:
      GoogleFonts.latoTextTheme(), // Встановлення текстової теми за допомогою шрифту Lato з Google Fonts
);

void main() {
  // Головна функція, яка запускається при старті застосунку
  runApp(
    const ProviderScope(child: App()),
  ); // Запуск Flutter-застосунку, обгорнутого в ProviderScope (для Riverpod)
}

// Кореневий віджет застосунку, є StatelessWidget
class App extends StatelessWidget {
  const App({super.key}); // Конструктор віджета App

  @override
  Widget build(BuildContext context) {
    // Метод build описує UI, який буде відображено для цього віджета
    return MaterialApp(
      // Віджет MaterialApp надає базову структуру Material Design для застосунку
      theme: theme, // Застосування визначеної теми оформлення
      home:
          const TabsScreen(), // Встановлення віджета TabsScreen як головного (першого) екрану
    );
  }
}
