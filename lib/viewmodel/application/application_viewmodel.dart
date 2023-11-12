import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/repository/Application/application_repository.dart';

import '../../model/Application/application_form.dart';

class ApplicationViewModel extends GetxController {
  final ApplicationRepository applicationRepository;

  ApplicationViewModel({required this.applicationRepository})
      : assert(applicationRepository != null);

  // If ApplicationForm can be null initially
  final Rx<ApplicationForm?> _applicationForm = Rx<ApplicationForm?>(null);
  final RxBool _isLoadingApplicationForm = false.obs;
  ApplicationForm? get applicationForm => _applicationForm.value;
  bool get isLoadingApplicationForm => _isLoadingApplicationForm.value;

  final RxMap<int, TextEditingController> _controllers = RxMap();
  Map<int, TextEditingController> get controllers => _controllers;

  final RxMap<int, String> _answers = RxMap();
  Map<int, String> get answers => _answers;

  void initFormControllersAndAnswers(ApplicationForm? form) {
    if (form != null) {
      for (var question in form.questions) {
        _controllers[question.questionId] = TextEditingController();
        _answers[question.questionId] = '';
      }
    }
  }

  void updateAnswer(int questionId, String answer) {
    _answers[questionId] = answer;
  }

  @override
  void onInit() {
    super.onInit();
    fetchApplicationForm();
    // After fetching the form, initialize the controllers and answers
    initFormControllersAndAnswers(_applicationForm.value);
  }

  void fetchApplicationForm() {
    _isLoadingApplicationForm.value = true;
    _applicationForm.value = applicationRepository.getApplicationForm();
    _isLoadingApplicationForm.value = false;
  }

  void submitApplicationForm() async {
    // Map the controllers to answers before submission
    controllers.forEach((questionId, controller) {
      answers[questionId] = controller.text.trim();
    });

    // TODO: Implement your submission logic, example:
    try {
      //Todo
      //bool success = await applicationRepository.submitApplicationForm(answers);
      if (true) {
        // Handle successful submission
        Get.snackbar('Success', 'Application submitted successfully!');
      } else {
        // Handle failure of submission
        Get.snackbar('Error', 'Failed to submit application.');
      }
    } catch (e) {
      // Handle the error properly
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }
}
