import 'package:intl/intl.dart';

import 'application_question.dart';

class ApplicationForm {
  final String clubName;
  final DateTime startDate;
  final DateTime endDate;
  final List<Questions> questions;

  ApplicationForm({
    required this.clubName,
    required this.startDate,
    required this.endDate,
    required this.questions,
  });

  String get date {
    String startDateStr = DateFormat('yyyy-MM-dd HH:mm').format(startDate);
    String endDateStr = DateFormat('yyyy-MM-dd HH:mm').format(endDate);

    print(startDateStr + " ~ " + endDateStr);
    if (startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day) {
      endDateStr = DateFormat('HH:mm').format(endDate);
    }

    return "$startDateStr ~ $endDateStr";
  }

  factory ApplicationForm.fromJson(Map<String, dynamic> json) {
    return ApplicationForm(
      clubName: json['clubName'],
      startDate: DateTime.parse(json['startDate']).toLocal(),
      endDate: DateTime.parse(json['endDate']).toLocal(),
      questions: (json['applicationQuestionResponseDtos'] as List)
              ?.map<Questions>((json) => Questions.fromJson(json))
              ?.toList() ??
          [],
    );
  }

  factory ApplicationForm.empty() {
    return ApplicationForm(
      clubName: "가입한 동아리가 없습니다!",
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      questions: [],
    );
  }
}
