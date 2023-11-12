import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/provider/Application/application_provider.dart';
import 'package:jjoin/viewmodel/application/application_viewmodel.dart';
import '../../../repository/Application/application_repository.dart';
import '../../widget/application/application_question_widget.dart';
import '../../widget/base/default_back_appbar.dart';
import '../../widget/application/application_top_bar_widget.dart';

class ClubApplicationScreen extends StatefulWidget {
  const ClubApplicationScreen({Key? key}) : super(key: key);

  @override
  State<ClubApplicationScreen> createState() => _ClubApplicationScreenState();
}

class _ClubApplicationScreenState extends State<ClubApplicationScreen> {
  late final ApplicationViewModel _applicationViewModel;

  @override
  void initState() {
    super.initState();
    _applicationViewModel = Get.put<ApplicationViewModel>(ApplicationViewModel(
      applicationRepository: ApplicationRepository(
        applicationProvider: Get.put(ApplicationProvider()),
      ),
    ));
    // for (var question in _applicationViewModel.applicationForm!.questions) {
    //   _applicationViewModel.controllers[question.questionId] =
    //       TextEditingController();
    //   _applicationViewModel.answers[question.questionId] = '';
    // }
  }

  @override
  void dispose() {
    for (var controller in _applicationViewModel.controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateAnswer(int questionId, String answer) {
    setState(() {
      _applicationViewModel.answers[questionId] = answer;
    });
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
          ApplicationTopBar(
              applicationForm: _applicationViewModel.applicationForm!),
          const SizedBox(height: 10), // Add some spacing
          ..._applicationViewModel.applicationForm!.questions.map((question) {
            TextEditingController? controller =
                _applicationViewModel.controllers[question.questionId];
            if (controller == null) {
              controller = TextEditingController();
              _applicationViewModel.controllers[question.questionId] =
                  controller;
            }
            return ApplicationQuestion(
              questionText: question.question,
              controller: controller,
              onAnswerChanged: (value) =>
                  _updateAnswer(question.questionId, value),
            );
          }).toList(),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(352.7, 40),
                backgroundColor: Colors.green.withOpacity(0.8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onPressed: _applicationViewModel.submitApplicationForm,
              child: const Text('제출하기',
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
