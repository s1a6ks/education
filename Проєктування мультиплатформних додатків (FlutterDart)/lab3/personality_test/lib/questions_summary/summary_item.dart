import 'package:flutter/material.dart';

import 'package:personality_test/questions_summary/question_identifier.dart';

class SummaryItem extends StatelessWidget {
  const SummaryItem(this.itemData, {super.key});

  final Map<String, Object> itemData;

  Color get typeColor {
    final answerType = itemData['answer_type'] as String;
    switch (answerType) {
      case 'logical':
        return Colors.blue;
      case 'creative':
        return Colors.purple;
      case 'practical':
        return Colors.green;
      default:
        return Colors.grey;
    }
  }

  String get typeLabel {
    final answerType = itemData['answer_type'] as String;
    switch (answerType) {
      case 'logical':
        return 'Логік';
      case 'creative':
        return 'Креативник';
      case 'practical':
        return 'Практик';
      default:
        return 'Невизначено';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          QuestionIdentifier(
            questionIndex: itemData['question_index'] as int,
            typeColor: typeColor,
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  itemData['question'] as String,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  itemData['user_answer'] as String,
                  style: TextStyle(
                    color: typeColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '(${typeLabel})',
                  style: TextStyle(
                    color: typeColor.withOpacity(0.7),
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}