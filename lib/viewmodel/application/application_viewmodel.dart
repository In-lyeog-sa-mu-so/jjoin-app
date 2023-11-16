import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/application/application_form.dart';
import '../../repository/application/application_repository.dart';

class ApplicationViewModel extends GetxController {
  final int clubId;
  final ApplicationRepository applicationRepository;

  ApplicationViewModel(
      {required this.clubId, required this.applicationRepository});

  // If ApplicationForm can be null initially
  late final Rx<ApplicationForm> _applicationForm;
  final RxBool _isLoadingApplicationForm = false.obs;
  ApplicationForm get applicationForm => _applicationForm.value;
  bool get isLoadingApplicationForm => _isLoadingApplicationForm.value;

  final RxMap<int, TextEditingController> _controllers = RxMap();
  Map<int, TextEditingController> get controllers => _controllers;

  final RxMap<int, String> _answers = RxMap();
  Map<int, String> get answers => _answers;

  void initFormControllersAndAnswers(ApplicationForm form) {
    if (form != null) {
      for (var question in form.questions) {
        _controllers[question.id] = TextEditingController();
        _answers[question.id] = '';
      }
    }
  }

  void updateAnswer(int questionId, String answer) {
    _answers[questionId] = answer;
  }

  @override
  void onInit() {
    super.onInit();
    initApplicationForm()
        .then((_) => initFormControllersAndAnswers(_applicationForm.value));
  }

  Future<void> initApplicationForm() async {
    _isLoadingApplicationForm.value = true;
    applicationRepository
        .readApplicationForm(clubId)
        .then((value) => _applicationForm = value.obs)
        .then((_) => _isLoadingApplicationForm.value = false);
    print(_applicationForm.value);
  }

  void fetchApplicationForm() {
    _isLoadingApplicationForm.value = true;
    applicationRepository
        .readApplicationForm(clubId)
        .then((value) => _applicationForm.value = value)
        .then((_) => _isLoadingApplicationForm.value = false);
  }

  bool checkAnswer() {
    for (var answer in _answers.values) {
      if (answer == '') {
        return false;
      }
    }
    return true;
  }

  void submitApplicationForm() async {
    controllers.forEach((questionId, controller) {
      answers[questionId] = controller.text.trim();
    });

    Map<String, dynamic> submissionData = {
      "data": answers.entries
          .map((entry) =>
              {"questionId": entry.key, "answerContent": entry.value})
          .toList()
    };

    String jsonSubmissionData = jsonEncode(submissionData);

    applicationRepository.postApplicationForm(clubId, jsonSubmissionData);
  }
}
