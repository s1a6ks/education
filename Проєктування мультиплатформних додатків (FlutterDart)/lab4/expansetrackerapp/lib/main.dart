import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter
import 'package:expense_tracker/widgets/expenses.dart'; // Імпорт файлу з віджетом для відображення витрат

// Визначення колірної схеми для світлої теми на основі заданого кольору (seedColor)
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(
    255,
    96,
    59,
    181,
  ), // Колір-основа для генерації світлої колірної схеми
);

// Визначення колірної схеми для темної теми
var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark, // Вказує, що це темна колірна схема
  seedColor: const Color.fromARGB(
    255,
    5,
    99,
    125,
  ), // Колір-основа для генерації темної колірної схеми
);

void main() {
  // Головна функція, яка запускається при старті застосунку
  runApp(
    // Запуск Flutter-застосунку
    MaterialApp(
      // Налаштування темної теми застосунку
      darkTheme: ThemeData.dark().copyWith(
        // Створення копії стандартної темної теми та її налаштування
        colorScheme:
            kDarkColorScheme, // Встановлення кастомної темної колірної схеми
        cardTheme: const CardTheme().copyWith(
          // Налаштування стилю віджетів Card у темній темі
          color:
              kDarkColorScheme
                  .secondaryContainer, // Колір вторинного контейнера
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ), // Відступи для Card
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          // Налаштування стилю віджетів ElevatedButton у темній темі
          style: ElevatedButton.styleFrom(
            backgroundColor:
                kDarkColorScheme
                    .primaryContainer, // Колір первинного контейнера кнопки
            foregroundColor:
                kDarkColorScheme
                    .onPrimaryContainer, // Колір тексту на первинному контейнері кнопки
          ),
        ),
      ),
      // Налаштування світлої теми застосунку
      theme: ThemeData().copyWith(
        // Створення копії стандартної світлої теми та її налаштування
        colorScheme:
            kColorScheme, // Встановлення кастомної світлої колірної схеми
        appBarTheme: const AppBarTheme().copyWith(
          // Налаштування стилю віджетів AppBar у світлій темі
          backgroundColor: kColorScheme.onPrimaryContainer, // Колір фону AppBar
          foregroundColor:
              kColorScheme.primaryContainer, // Колір тексту та іконок на AppBar
        ),
        cardTheme: const CardTheme().copyWith(
          // Налаштування стилю віджетів Card у світлій темі
          color: kColorScheme.secondaryContainer, // Колір вторинного контейнера
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ), // Відступи для Card
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          // Налаштування стилю віджетів ElevatedButton у світлій темі
          style: ElevatedButton.styleFrom(
            backgroundColor:
                kColorScheme
                    .primaryContainer, // Колір первинного контейнера кнопки
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
          // Налаштування стилю тексту у світлій темі
          titleLarge: TextStyle(
            // Стиль для великих заголовків (titleLarge)
            fontWeight: FontWeight.bold, // Жирний шрифт
            color:
                kColorScheme
                    .onSecondaryContainer, // Колір тексту на вторинному контейнері
            fontSize: 16, // Розмір шрифту
          ),
        ),
      ),
      // themeMode: ThemeMode.system, // default // Коментар: Вказує, що режим теми за замовчуванням - системний (світла або темна залежно від налаштувань пристрою)
      home:
          const Expenses(), // Встановлення віджета Expenses як головного (першого) екрану застосунку
    ),
  );
}
