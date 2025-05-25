// Перелік для визначення рівня складності приготування страви
enum Complexity {
  simple, // Простий
  challenging, // Середній (викликає труднощі)
  hard, // Складний
}

// Перелік для визначення рівня доступності страви за ціною
enum Affordability {
  affordable, // Доступний за ціною
  pricey, // Дорогий
  luxurious, // Розкішний
}

// Визначення класу Meal - моделі даних для страви
class Meal {
  // Конструктор класу Meal. Позначається як const, що дозволяє створювати константні екземпляри цього класу.
  const Meal({
    required this.id, // Обов'язковий параметр: унікальний ідентифікатор страви
    required this.categories, // Обов'язковий параметр: список ідентифікаторів категорій, до яких належить страва
    required this.title, // Обов'язковий параметр: назва страви
    required this.imageUrl, // Обов'язковий параметр: URL зображення страви
    required this.ingredients, // Обов'язковий параметр: список інгредієнтів
    required this.steps, // Обов'язковий параметр: список кроків приготування
    required this.duration, // Обов'язковий параметр: тривалість приготування у хвилинах
    required this.complexity, // Обов'язковий параметр: рівень складності приготування (використовується enum Complexity)
    required this.affordability, // Обов'язковий параметр: рівень доступності за ціною (використовується enum Affordability)
    required this.isGlutenFree, // Обов'язковий параметр: чи страва без глютену
    required this.isLactoseFree, // Обов'язковий параметр: чи страва без лактози
    required this.isVegan, // Обов'язковий параметр: чи страва веганська
    required this.isVegetarian, // Обов'язковий параметр: чи страва вегетаріанська
    required this.isLowCarb, // Обов'язковий параметр: чи страва з низьким вмістом вуглеводів
  });

  final String id; // Властивість для зберігання ідентифікатора страви
  final List<String>
  categories; // Властивість для зберігання списку категорій, до яких належить страва
  final String title; // Властивість для зберігання назви страви
  final String imageUrl; // Властивість для зберігання URL зображення страви
  final List<String>
  ingredients; // Властивість для зберігання списку інгредієнтів
  final List<String>
  steps; // Властивість для зберігання списку кроків приготування
  final int duration; // Властивість для зберігання тривалості приготування
  final Complexity
  complexity; // Властивість для зберігання рівня складності приготування
  final Affordability
  affordability; // Властивість для зберігання рівня доступності за ціною
  final bool isGlutenFree; // Властивість для зберігання статусу "без глютену"
  final bool isLactoseFree; // Властивість для зберігання статусу "без лактози"
  final bool isVegan; // Властивість для зберігання статусу "веганська"
  final bool isLowCarb;
  final bool
  isVegetarian; // Властивість для зберігання статусу "вегетаріанська"
}
