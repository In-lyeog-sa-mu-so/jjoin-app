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

class ApplicationForm {
  final int applicationId;
  final String clubName;
  final DateTime startDate;
  final DateTime endDate;
  final List<Questions> questions;

  ApplicationForm({
    required this.applicationId,
    required this.clubName,
    required this.startDate,
    required this.endDate,
    required this.questions,
  });

  factory ApplicationForm.fromJson(Map<String, dynamic> json) {
    return ApplicationForm(
      applicationId: json['id'],
      clubName: json['clubName'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
      questions: json['questions'],
    );
  }
}

ApplicationForm applicationForm = ApplicationForm(
    applicationId: 1,
    clubName: "컴공 학생회",
    startDate: DateTime.parse("2023-11-01"),
    endDate: DateTime.parse("2023-11-31"),
    questions: [
      Questions(
        questionId: 12,
        question: "이름",
      ),
      Questions(
        questionId: 32,
        question: "학번",
      ),
      Questions(
        questionId: 3,
        question: "전공",
      ),
      Questions(
        questionId: 3,
        question: "Email",
      ),
      Questions(
        questionId: 44,
        question: "연락처",
      ),
      Questions(
        questionId: 51,
        question: "동아리에 지원하게 된 동기는 무엇인가요?",
      ),
    ]);
