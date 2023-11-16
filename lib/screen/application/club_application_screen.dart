import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/viewmodel/application/application_viewmodel.dart';
import '../../provider/application/application_local_provider.dart';
import '../../provider/application/application_provider.dart';
import '../../repository/application/application_repository.dart';
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
  late final int _clubId;

  @override
  void initState() {
    super.initState();
    _clubId = Get.arguments["clubId"];
    _applicationViewModel = Get.put<ApplicationViewModel>(
      ApplicationViewModel(
        clubId: _clubId,
        applicationRepository: ApplicationRepository(
          applicationLocalProvider: Get.put(ApplicationLocalProvider()),
          applicationProvider: Get.put(ApplicationProvider()),
        ),
      ),
    );
  }

  @override
  void dispose() {
    for (var controller in _applicationViewModel.controllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _updateAnswer(int questionId, String answer) {
    _applicationViewModel.updateAnswer(questionId, answer);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: DefaultBackAppbar(title: '가입 신청서'),
      ),
      body: Obx(() {
        if (_applicationViewModel.isLoadingApplicationForm) {
          return const Center(child: CircularProgressIndicator());
        } else if (_applicationViewModel.applicationForm == null) {
          return const Center(
              child: Text("Application form is not available."));
        } else {
          var form = _applicationViewModel.applicationForm;
          return ListView(
            children: [
              ApplicationTopBar(applicationForm: form),
              const SizedBox(height: 10),
              ...form.questions.map((question) {
                var controller = _applicationViewModel.controllers
                    .putIfAbsent(question.id, () => TextEditingController());
                return ApplicationQuestion(
                  questionText: question.content,
                  controller: controller,
                  onAnswerChanged: (value) => _updateAnswer(question.id, value),
                );
              }).toList(),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 20),
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
          );
        }
      }),
    );
  }
}
