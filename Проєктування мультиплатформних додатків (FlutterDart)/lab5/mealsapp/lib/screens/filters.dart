import 'package:flutter/material.dart'; // Імпорт основної бібліотеки віджетів Flutter (для Material Design)

// import 'package:meals/screens/tabs.dart'; // Закоментований імпорт, можливо, використовувався раніше для навігації
// import 'package:meals/widgets/main_drawer.dart'; // Закоментований імпорт, можливо, використовувався для бокового меню

// Перелік можливих типів фільтрів
enum Filter {
  glutenFree, // Без глютену
  lactoseFree, // Без лактози
  vegetarian, // Вегетаріанська
  vegan, // Веганська
  lowCarb, // Низьковуглеводна
}

// Віджет FiltersScreen є StatefulWidget, оскільки стан фільтрів змінюється
class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.currentFilters,
  }); // Конструктор, який приймає поточні налаштування фільтрів

  final Map<Filter, bool>
  currentFilters; // Мапа, що зберігає поточні налаштування фільтрів

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState(); // Створення стану для віджета FiltersScreen
  }
}

// Клас _FiltersScreenState представляє стан віджета FiltersScreen
class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false; // Змінна стану для фільтра "без глютену"
  var _lactoseFreeFilterSet = false; // Змінна стану для фільтра "без лактози"
  var _vegetarianFilterSet = false; // Змінна стану для фільтра "вегетаріанська"
  var _veganFilterSet = false; // Змінна стану для фільтра "веганська"
  var _lowCarbFilterSet = false;

  @override
  void initState() {
    // Метод, який викликається при створенні віджета (перед build)
    super.initState(); // Виклик методу initState батьківського класу
    // Ініціалізація змінних стану на основі поточних фільтрів, отриманих через widget.currentFilters
    _glutenFreeFilterSet =
        widget.currentFilters[Filter
            .glutenFree]!; // ! - оператор "null assertion", припускаємо, що ключ існує
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  @override
  Widget build(BuildContext context) {
    // Метод build описує UI екрану фільтрів
    return Scaffold(
      // Віджет Scaffold надає базову структуру екрану
      appBar: AppBar(
        title: const Text('Your Filters'), // Заголовок у панелі застосунку
      ),
      // drawer: MainDrawer( // Закоментований бічний меню
      //   onSelectScreen: (identifier) {
      //     Navigator.of(context).pop();
      //     if (identifier == 'meals') {
      //       Navigator.of(context).pushReplacement(
      //         MaterialPageRoute(
      //           builder: (ctx) => const TabsScreen(),
      //         ),
      //       );
      //     }
      //   },
      // ),
      body: WillPopScope(
        // Віджет WillPopScope перехоплює спробу "вийти" з екрану (наприклад, натисканням кнопки "Назад")
        onWillPop: () async {
          // Функція, яка виконується при спробі "вийти" з екрану
          Navigator.of(context).pop({
            // "Виходимо" з екрану та передаємо назад мапу з поточними налаштуваннями фільтрів
            Filter.glutenFree: _glutenFreeFilterSet,
            Filter.lactoseFree: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
            Filter.lowCarb: _lowCarbFilterSet,
          });
          return false; // Повернення false запобігає стандартній дії кнопки "Назад"
        },
        child: Column(
          // Вміст екрану, розташований у вертикальному стовпці
          children: [
            // Віджет SwitchListTile для фільтра "без глютену"
            SwitchListTile(
              value: _glutenFreeFilterSet, // Поточне значення перемикача
              onChanged: (isChecked) {
                // Функція, яка викликається при зміні стану перемикача
                setState(() {
                  _glutenFreeFilterSet =
                      isChecked; // Оновлення стану змінної та перемалювання UI
                });
              },
              title: Text(
                // Заголовок перемикача
                'Gluten-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  // Стиль заголовка
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                // Підзаголовок перемикача
                'Only include gluten-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  // Стиль підзаголовка
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor:
                  Theme.of(
                    context,
                  ).colorScheme.tertiary, // Колір перемикача у активному стані
              contentPadding: const EdgeInsets.only(
                left: 34,
                right: 22,
              ), // Внутрішні відступи контенту
            ),
            // Аналогічні SwitchListTile для інших фільтрів: без лактози, вегетаріанська, веганська
            SwitchListTile(
              value: _lactoseFreeFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lactoseFreeFilterSet = isChecked;
                });
              },
              title: Text(
                'Lactose-free',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include lactose-free meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
            SwitchListTile(
              value: _vegetarianFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _vegetarianFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include vegetarian meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),

            SwitchListTile(
              value: _lowCarbFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _lowCarbFilterSet = isChecked;
                });
              },


              title: Text(
                'Low Carb',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include low-carb meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
                activeColor: Theme.of(context).colorScheme.tertiary,
               contentPadding: const EdgeInsets.only(left: 34, right: 22),


            ),
            SwitchListTile(
              value: _veganFilterSet,
              onChanged: (isChecked) {
                setState(() {
                  _veganFilterSet = isChecked;
                });
              },
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              subtitle: Text(
                'Only include vegan meals.',
                style: Theme.of(context).textTheme.labelMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              activeColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: const EdgeInsets.only(left: 34, right: 22),
            ),
          ],
        ),
      ),
    );
  }
}
