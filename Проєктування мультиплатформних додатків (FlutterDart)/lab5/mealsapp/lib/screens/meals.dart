import 'package:flutter/material.dart';

import 'package:meals/models/meal.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/widgets/meal_item.dart';

enum SortOption { byTitle, byDuration, byComplexity }

class MealsScreen extends StatefulWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
    required this.favoriteMeals,
  });

  final String? title;
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> favoriteMeals;

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  String _searchQuery = '';
  SortOption _sortOption = SortOption.byTitle; // Початковий критерій сортування

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: widget.onToggleFavorite,
          isFavorite: widget.favoriteMeals.contains(meal),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Фільтрація за пошуком
    final filteredMeals = widget.meals.where((meal) {
      return meal.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    // Сортування згідно з вибраним критерієм
    filteredMeals.sort((a, b) {
      switch (_sortOption) {
        case SortOption.byTitle:
          return a.title.compareTo(b.title);
        case SortOption.byDuration:
          return a.duration.compareTo(b.duration);
        case SortOption.byComplexity:
          // Припускаємо, що complexity - enum, якщо ні - адаптуй
          return a.complexity.index.compareTo(b.complexity.index);
      }
    });

    Widget content;

    if (filteredMeals.isEmpty) {
      content = Center(
        child: Text(
          'No meals found.',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      );
    } else {
     content = Column(
  children: [
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          // Dropdown зліва
          DropdownButton<SortOption>(
            value: _sortOption,
            items: const [
              DropdownMenuItem(
                value: SortOption.byTitle,
                child: Text('Sort by Title'),
              ),
              DropdownMenuItem(
                value: SortOption.byDuration,
                child: Text('Sort by Duration'),
              ),
              DropdownMenuItem(
                value: SortOption.byComplexity,
                child: Text('Sort by Complexity'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  _sortOption = value;
                });
              }
            },
          ),

          const SizedBox(width: 12), // відступ між Dropdown і полем пошуку

          // Поле пошуку займає залишок простору
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search meals...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ],
      ),
    ),

    Expanded(
      child: ListView.builder(
        itemCount: filteredMeals.length,
        itemBuilder: (ctx, index) => MealItem(
          meal: filteredMeals[index],
          onSelectMeal: (meal) => _selectMeal(context, meal),
        ),
      ),
    ),
  ],
);
    }

    if (widget.title == null) {
      return content;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: content,
    );
  }
}
