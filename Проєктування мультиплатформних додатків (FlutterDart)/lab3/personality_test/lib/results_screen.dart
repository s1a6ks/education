import 'package:flutter/material.dart';

import 'package:personality_test/data/questions.dart';
import 'package:personality_test/questions_summary/questions_summary.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.chosenAnswers,
    required this.onRestart,
  });

  final void Function() onRestart;
  final List<String> chosenAnswers;

  List<Map<String, Object>> get summaryData {
    final List<Map<String, Object>> summary = [];

    for (var i = 0; i < chosenAnswers.length; i++) {
      summary.add(
        {
          'question_index': i,
          'question': questions[i].text,
          'user_answer': chosenAnswers[i],
          'answer_type': questions[i].answerTypes[questions[i].answers.indexOf(chosenAnswers[i])]
        },
      );
    }

    return summary;
  }

  Map<String, int> get resultCounts {
    final Map<String, int> counts = {
      'logical': 0,
      'creative': 0,
      'practical': 0,
    };
    
    for (final data in summaryData) {
      final answerType = data['answer_type'] as String;
      counts[answerType] = (counts[answerType] ?? 0) + 1;
    }
    
    return counts;
  }
  
  String get dominantType {
    final counts = resultCounts;
    String dominant = 'logical';
    int maxCount = counts['logical'] ?? 0;
    
    counts.forEach((type, count) {
      if (count > maxCount) {
        maxCount = count;
        dominant = type;
      }
    });
    
    return dominant;
  }
  
  String get resultText {
    switch (dominantType) {
      case 'logical':
        return 'Ви - Логік!\n\nВи схильні до аналітичного мислення, любите факти та логічні міркування. Ви часто шукаєте структуру та порядок у всьому, що робите. Вам важливо розуміти причинно-наслідкові зв\'язки.';
      case 'creative':
        return 'Ви - Креативник!\n\nВаше мислення відрізняється оригінальністю та інноваційністю. Ви бачите можливості там, де інші бачать перешкоди. Ви любите експериментувати та шукати нестандартні рішення.';
      case 'practical':
        return 'Ви - Практик!\n\nВи орієнтовані на результат і любите діяти. Ваше мислення спрямоване на пошук найбільш ефективних та реалістичних рішень. Ви цінуєте досвід та перевірені методи.';
      default:
        return 'Цікавий результат! У вас збалансовані типи мислення.';
    }
  }

  @override
  Widget build(BuildContext context) {
    final counts = resultCounts;
    
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Результати тесту',
              style: TextStyle(
                color: Color.fromARGB(255, 230, 230, 250),
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Text(
              resultText,
              style: const TextStyle(
                color: Color.fromARGB(255, 220, 233, 248),
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _ResultBar(
                  label: 'Логік',
                  value: counts['logical'] ?? 0,
                  maxValue: questions.length,
                  color: Colors.blue,
                ),
                const SizedBox(width: 10),
                _ResultBar(
                  label: 'Креативник',
                  value: counts['creative'] ?? 0,
                  maxValue: questions.length,
                  color: Colors.purple,
                ),
                const SizedBox(width: 10),
                _ResultBar(
                  label: 'Практик',
                  value: counts['practical'] ?? 0,
                  maxValue: questions.length,
                  color: Colors.green,
                ),
              ],
            ),
            const SizedBox(height: 30),
            QuestionsSummary(summaryData),
            const SizedBox(height: 30),
            TextButton.icon(
              onPressed: onRestart,
              style: TextButton.styleFrom(
                foregroundColor: Colors.white,
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Пройти тест знову'),
            )
          ],
        ),
      ),
    );
  }
}

class _ResultBar extends StatelessWidget {
  const _ResultBar({
    required this.label,
    required this.value,
    required this.maxValue,
    required this.color,
  });

  final String label;
  final int value;
  final int maxValue;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          height: 100,
          width: 40,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: (value / maxValue) * 100,
                width: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(6),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 5),
        Text(
          '$value',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}