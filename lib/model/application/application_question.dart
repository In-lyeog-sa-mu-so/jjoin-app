class Questions {
  final int questionId;
  final String question;

  Questions({
    required this.questionId,
    required this.question,
  });

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      questionId: json['questionId'],
      question: json['question'],
    );
  }
}
