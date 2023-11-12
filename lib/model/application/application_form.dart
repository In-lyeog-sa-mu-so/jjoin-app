import 'application_question.dart';

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
}
