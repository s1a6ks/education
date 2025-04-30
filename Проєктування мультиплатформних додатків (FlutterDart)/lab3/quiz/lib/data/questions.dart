import 'package:quiz/models/quiz_question.dart'; // Імпорт кастомного класу QuizQuestion, який представляє питання вікторини.

const questions = [
  // Оголошення константного списку questions, що містить об'єкти QuizQuestion.
  QuizQuestion(
    // Створення першого об'єкта QuizQuestion.
    'What are the main building blocks of Flutter UIs?', // Текст першого питання.
    [
      // Список варіантів відповідей на перше питання (перший елемент - правильна відповідь).
      'Widgets',
      'Components',
      'Blocks',
      'Functions',
    ],
  ),
  QuizQuestion('How are Flutter UIs built?', [
    // Створення другого об'єкта QuizQuestion.
    'By combining widgets in code', // Правильна відповідь.
    'By combining widgets in a visual editor',
    'By defining widgets in config files',
    'By using XCode for iOS and Android Studio for Android',
  ]),
  QuizQuestion(
    // Створення третього об'єкта QuizQuestion.
    'What\'s the purpose of a StatefulWidget?', // Текст третього питання.
    [
      // Список варіантів відповідей на третє питання.
      'Update UI as data changes', // Правильна відповідь.
      'Update data as UI changes',
      'Ignore data changes',
      'Render UI that does not depend on data',
    ],
  ),
  QuizQuestion(
    // Створення четвертого об'єкта QuizQuestion.
    'Which widget should you try to use more often: StatelessWidget or StatefulWidget?', // Текст четвертого питання.
    [
      // Список варіантів відповідей на четверте питання.
      'StatelessWidget', // Правильна відповідь.
      'StatefulWidget',
      'Both are equally good',
      'None of the above',
    ],
  ),
  QuizQuestion(
    // Створення п'ятого об'єкта QuizQuestion.
    'What happens if you change data in a StatelessWidget?', // Текст п'ятого питання.
    [
      // Список варіантів відповідей на п'яте питання.
      'The UI is not updated', // Правильна відповідь.
      'The UI is updated',
      'The closest StatefulWidget is updated',
      'Any nested StatefulWidgets are updated',
    ],
  ),
  QuizQuestion(
    // Створення шостого об'єкта QuizQuestion.
    'How should you update data inside of StatefulWidgets?', // Текст шостого питання.
    [
      // Список варіантів відповідей на шосте питання.
      'By calling setState()', // Правильна відповідь.
      'By calling updateData()',
      'By calling updateUI()',
      'By calling updateState()',
    ],
  ),
];
