class TestQuestion {
  const TestQuestion(this.text, this.answers, this.answerTypes);

  final String text;
  final List<String> answers;
  final List<String> answerTypes;

  List<String> get shuffledAnswers {
    final shuffledList = List.of(answers);
    shuffledList.shuffle();
    return shuffledList;
  }
}