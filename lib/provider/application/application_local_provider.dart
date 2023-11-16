import 'package:get/get.dart';

import '../../model/application/application_form.dart';
import '../../model/application/application_question.dart';

class ApplicationLocalProvider extends GetConnect {
  ApplicationForm getDummyApplicationForm() {
    ApplicationForm applicationForm = ApplicationForm(
        clubName: "컴퓨터공학과 학생회",
        startDate: DateTime.parse("2023-11-01"),
        endDate: DateTime.parse("2023-11-31"),
        questions: [
          Questions(
            id: 3,
            content: "Email",
          ),
          Questions(
            id: 44,
            content: "연락처",
          ),
          Questions(
            id: 51,
            content: "동아리에 지원하게 된 동기는 무엇인가요?",
          ),
        ]);
    return applicationForm;
  }

  Future<void> postApplication(
      int clubId, int applicationId, Map<int, String> answers) async {}
}
