import 'package:get/get.dart';
import 'package:jjoin/model/Application/application_question.dart';

import '../../model/Application/application_form.dart';

class ApplicationProvider extends GetConnect {
  ApplicationForm getDummyApplicationForm() {
    ApplicationForm applicationForm = ApplicationForm(
        applicationId: 1,
        clubName: "컴퓨터공학과 학생회",
        startDate: DateTime.parse("2023-11-01"),
        endDate: DateTime.parse("2023-11-31"),
        questions: [
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
          Questions(
            questionId: 52,
            question: "주량은 몇병인가요?",
          ),
          Questions(
            questionId: 53,
            question: "각각 1지망, 2지망 희망하는 국을 적어주세요.",
          ),
          Questions(
            questionId: 54,
            question: "잘하는 것은 무엇인가요?",
          ),
        ]);
    return applicationForm;
  }

  Future<void> postApplication(
      int clubId, int applicationId, Map<int, String> answers) async {}
}
