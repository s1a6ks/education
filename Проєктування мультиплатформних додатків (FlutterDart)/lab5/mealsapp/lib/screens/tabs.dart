import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter (для Material Design, Scaffold, AppBar, BottomNavigationBar тощо)

import 'package:meals/data/dummy_data.dart'; // Імпорт файлу з фіктивними даними (для доступу до dummyMeals)
import 'package:meals/models/meal.dart'; // Імпорт файлу з моделлю даних Страви
import 'package:meals/screens/categories.dart'; // Імпорт файлу з віджетом екрану Категорій
import 'package:meals/screens/filters.dart'; // Імпорт файлу з віджетом екрану Фільтрів
import 'package:meals/screens/meals.dart'; // Імпорт файлу з віджетом екрану Списку страв
import 'package:meals/widgets/main_drawer.dart'; // Імпорт файлу з віджетом головного бокового меню

// Константа: Початкові налаштування фільтрів
const kInitialFilters = {
  Filter.glutenFree: false, // Фільтр "без глютену" вимкнено за замовчуванням
  Filter.lactoseFree: false, // Фільтр "без лактози" вимкнено за замовчуванням
  Filter.vegetarian: false, // Фільтр "вегетаріанська" вимкнено за замовчуванням
  Filter.vegan: false, // Фільтр "веганська" вимкнено за замовчуванням
  Filter.lowCarb: false, // Фільтр "низьковуглеводна" вимкнено за замовчуванням
};

// Віджет TabsScreen є StatefulWidget, оскільки стан (обрана вкладка, улюблені страви, фільтри) змінюється
class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key}); // Конструктор віджета TabsScreen

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState(); // Створення стану для віджета TabsScreen
  }
}

// Клас _TabsScreenState представляє стан віджета TabsScreen
class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex =
      0; // Змінна стану: індекс поточної обраної вкладки (0 - Категорії, 1 - Улюблені)
  final List<Meal> _favoriteMeals = []; // Змінна стану: список улюблених страв
  Map<Filter, bool> _selectedFilters =
      kInitialFilters; // Змінна стану: поточні обрані фільтри, ініціалізовані початковими значеннями

  // Приватний метод для відображення інформаційного повідомлення (SnackBar)
  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).clearSnackBars(); // Очищення попередніх SnackBar
    ScaffoldMessenger.of(context).showSnackBar(
      // Відображення нового SnackBar
      SnackBar(
        content: Text(message), // Текст повідомлення
      ),
    );
  }

  // Метод для перемикання статусу страви "улюблене"
  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(
      meal,
    ); // Перевірка, чи страва вже є в списку улюблених

    if (isExisting) {
      // Якщо страва вже улюблена, видаляємо її зі списку
      setState(() {
        _favoriteMeals.remove(meal);
      }); // Оновлення стану та перемалювання UI
      _showInfoMessage(
        'Meal is no longer a favorite.',
      ); // Відображення повідомлення
    } else {
      // Якщо страва не улюблена, додаємо її до списку
      setState(() {
        _favoriteMeals.add(meal);
        _showInfoMessage('Marked as a favorite!');
      }); // Оновлення стану та перемалювання UI
    }
  }

  // Метод для зміни обраної вкладки за індексом
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex =
          index; // Оновлення індексу обраної вкладки та перемалювання UI
    });
  }

  // Метод для переходу до іншого екрану з бокового меню
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // Закриття бокового меню

    if (identifier == 'filters') {
      // Якщо обрано пункт "Filters"
      // Здійснюємо навігацію на екран фільтрів та чекаємо на результат (налаштування фільтрів)
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder:
              (ctx) => FiltersScreen(
                currentFilters:
                    _selectedFilters, // Передача поточних налаштувань фільтрів на екран фільтрів
              ),
        ),
      );

      // Оновлюємо стан з обраними фільтрами після повернення з екрану фільтрів
      setState(() {
        _selectedFilters =
            result ??
            kInitialFilters; // Встановлюємо отриманий результат або початкові фільтри, якщо результат null
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Фільтруємо загальний список фіктивних страв на основі поточних обраних фільтрів
    final availableMeals =
        dummyMeals.where((meal) {
          if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false; // Якщо фільтр "без глютену" увімкнено, а страва містить глютен - виключаємо
          }
          
          
          if (_selectedFilters[Filter.lowCarb]! && !meal.isLowCarb) {
            return false;
          }


          if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false; // Якщо фільтр "без лактози" увімкнено, а страва містить лактозу - виключаємо
          }
          if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
            return false; // Якщо фільтр "вегетаріанська" увімкнено, а страва не вегетаріанська - виключаємо
          }
          if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
            return false; // Якщо фільтр "веганська" увімкнено, а страва не веганська - виключаємо
          }
          return true; // В іншому випадку - включаємо страву до списку
        }).toList(); // Перетворення відфільтрованого списку на List

    // Визначення активного екрану (за замовчуванням - екран категорій)
    Widget activePage = CategoriesScreen(
      onToggleFavorite:
          _toggleMealFavoriteStatus, // Передача функції обробки "улюблене"
      availableMeals:
          availableMeals, // Передача відфільтрованого списку доступних страв
    );
    var activePageTitle = 'Categories'; // Заголовок для екрану категорій

    // Якщо обрана вкладка - "Улюблені"
    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals, // Відображаємо список улюблених страв
        onToggleFavorite:
            _toggleMealFavoriteStatus, favoriteMeals: [], // Передача функції обробки "улюблене"
      );
      activePageTitle = 'Your Favorites'; // Заголовок для екрану улюблених
    }

    // Побудова основного UI екрану з вкладками
    return Scaffold(
      // Віджет Scaffold надає базову структуру екрану
      appBar: AppBar(
        // Панель застосунку
        title: Text(
          activePageTitle,
        ), // Заголовок панелі застосунку (динамічний, залежить від обраної вкладки)
      ),
      drawer: MainDrawer(
        onSelectScreen:
            _setScreen, // Додавання бокового меню та передача функції для обробки вибору пункту меню
      ),
      body:
          activePage, // Тіло екрану - поточний активний екран (Категорії або Улюблені)
      bottomNavigationBar: BottomNavigationBar(
        // Нижня панель навігації
        onTap:
            _selectPage, // Функція, яка викликається при натисканні на елемент нижньої навігації (передається індекс)
        currentIndex:
            _selectedPageIndex, // Поточний активний індекс (для підсвічування активної вкладки)
        items: const [
          // Елементи нижньої панелі навігації (вкладки)
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal), // Іконка для вкладки "Категорії"
            label: 'Categories', // Мітка для вкладки "Категорії"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star), // Іконка для вкладки "Улюблені"
            label: 'Favorites', // Мітка для вкладки "Улюблені"
          ),
        ],
      ),
    );
  }
}
