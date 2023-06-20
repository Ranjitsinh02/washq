class QuestionModel {
  List<String> options;
  String question;
  List<int> correctAnswerIndices;

  QuestionModel(
      {required this.options,
      required this.question,
      required this.correctAnswerIndices});
}
