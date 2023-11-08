import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jjoin/provider/Application/application_provider.dart';
import '../../model/Application/application_question.dart';
import '../../repository/Application/application_repository.dart';

class ApplicationScreen extends StatefulWidget {
  const ApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ApplicationScreen> createState() => _ApplicationScreenState();
}

class _ApplicationScreenState extends State<ApplicationScreen> {
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
      appBar: AppBar(
        title: const Text('JJoin'), // AppBar title set to 'JJoin'
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${applicationForm.clubName} 가입 신청서', // Moved inside body
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              '모집 기간: ${DateFormat('yyyy-MM-dd').format(applicationForm.startDate)} ~ ${DateFormat('yyyy-MM-dd').format(applicationForm.endDate)}', // Recruitment period
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10), // Add some spacing
          ...applicationForm.questions.map((question) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(question.question,
                          style: const TextStyle(fontSize: 18)),
                      TextField(
                        controller: controllers[question.questionId],
                        onChanged: (value) {
                          _updateAnswer(question.questionId, value);
                        },
                        decoration: const InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 190.0, vertical: 16.0),
            child: Container(
              child: ElevatedButton(
                onPressed: _submitAnswers,
                child: const Text('제출',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
