import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jjoin/provider/Application/application_provider.dart';
import '../../model/Application/application_question.dart';
import '../../repository/Application/application_repository.dart';

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
      appBar: AppBar(
          // title: Image.asset(
          //   fit: BoxFit.cover,
          //   'assets/images/dgu_image.png', // You can choose how to fit the image within the AppBar.
          //   height: kToolbarHeight,
          // ),
          ),
      body: ListView(
        children: [
          _buildTopBar(applicationForm: applicationForm),
          const SizedBox(height: 10), // Add some spacing
          ...applicationForm.questions.map((question) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 6.0, horizontal: 2.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: Colors.grey.shade300,
                    width: 1.0,
                  ),
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
          Container(
            padding: const EdgeInsets.all(16.0),
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: _submitAnswers,
              child: const Text('제출',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class _buildTopBar extends StatelessWidget {
  const _buildTopBar({
    super.key,
    required this.applicationForm,
  });

  final ApplicationForm applicationForm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 1.0,
        ),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6.0),
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '${applicationForm.clubName} 가입 신청서',
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
              '모집 기간: ${DateFormat('yyyy-MM-dd').format(applicationForm.startDate)} ~ ${DateFormat('yyyy-MM-dd').format(applicationForm.endDate)}',
              style: const TextStyle(fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}