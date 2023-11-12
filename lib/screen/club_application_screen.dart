import 'package:flutter/material.dart';
import 'package:jjoin/provider/Application/application_provider.dart';
import '../../model/Application/application_question.dart';
import '../../repository/Application/application_repository.dart';
import '../widget/application/application_question_widget.dart';
import '../widget/base/default_back_appbar.dart';
import '../widget/application/application_top_bar_widget.dart';

class ClubApplicationScreen extends StatefulWidget {
  const ClubApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ClubApplicationScreen> createState() => _ClubApplicationScreenState();
}

class _ClubApplicationScreenState extends State<ClubApplicationScreen> {
  late final ApplicationForm applicationForm;
  final Map<int, TextEditingController> controllers = {};
  final Map<int, String> answers = {};

  @override
  void initState() {
    super.initState();
    applicationForm = ApplicationRepository.getDummyApplicationForm();
    for (var question in applicationForm.questions) {
      controllers[question.questionId] = TextEditingController();
      answers[question.questionId] = '';
    }
  }

  @override
  void dispose() {
    for (var controller in controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateAnswer(int questionId, String answer) {
    setState(() {
      answers[questionId] = answer;
    });
  }

  void _submitAnswers() async {
    try {
      await ApplicationProvider.postAnswer(1, applicationForm.applicationId,
          answers); // Assuming 1 is the placeholder for clubId and applicationId
      // TODO: Handle successful submission
      print('Answers submitted successfully.');
    } catch (e) {
      // TODO: Handle submission error
      print('Error submitting answers: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DefaultBackAppbar(title: '가입 신청서')),
      body: ListView(
        children: [
          ApplicationTopBar(applicationForm: applicationForm),
          const SizedBox(height: 10), // Add some spacing
          ...applicationForm.questions.map((question) {
            TextEditingController? controller =
                controllers[question.questionId];
            if (controller == null) {
              controller = TextEditingController();
              controllers[question.questionId] = controller;
            }
            return ApplicationQuestion(
              questionText: question.question,
              controller: controller,
              onAnswerChanged: (value) =>
                  _updateAnswer(question.questionId, value),
            );
          }).toList(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: _submitAnswers,
              child: const Text('제출',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
