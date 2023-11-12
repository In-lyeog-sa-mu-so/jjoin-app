import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:get/get.dart';

import '../../provider/Profile/profile_remote_provider.dart';
import '../../provider/profile/profile_local_provider.dart';
import '../../repository/profile/profile_repository.dart';
import '../../viewmodel/profile/profile_edit_viewmodel.dart';
import '../../widget/base/default_back_appbar.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({
    super.key,
  });

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late final ProfileEditViewModel _profileEditViewModel;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _profileEditViewModel = Get.put<ProfileEditViewModel>(ProfileEditViewModel(
      profileRepository: ProfileRepository(
        profileLocalProvider: Get.put(ProfileLocalProvider()),
        profileRemoteProvider: Get.put(ProfileRemoteProvider()),
      ),
    ));
    _descriptionController =
        TextEditingController(text: _profileEditViewModel.user!.introduction);
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _profileEditViewModel.updateProfileImage(File(pickedFile.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: DefaultBackAppbar(title: '프로필 수정')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: _pickImage,
                    child: CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage(
                          _profileEditViewModel.user!.profileImageUuid),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 6.0),
                            child: Text(
                              _profileEditViewModel.user!.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child:
                                Text('전공: ${_profileEditViewModel.user!.major}',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w300,
                                    )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                                '학번: ${_profileEditViewModel.user!.studentId.toString()}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 15),
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Column(
                  children: [
                    Obx(
                      () => TextField(
                        controller: _descriptionController,
                        decoration: const InputDecoration(
                          labelText: '자기소개',
                          labelStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                          ),
                          alignLabelWithHint: true,
                          border: OutlineInputBorder(),
                        ),
                        style: TextStyle(
                          color: _profileEditViewModel.isEditingText
                              ? Colors.black
                              : Colors.grey.shade600,
                        ),
                        maxLines: 15,
                        enabled: _profileEditViewModel.isEditingText,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Start editing the profile
                            _profileEditViewModel.startEditing();
                          },
                          child: const Text('수정하기'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _profileEditViewModel.saveProfile(
                              _descriptionController.text,
                              _profileEditViewModel.profileImage,
                            );
                          },
                          child: const Text('저장하기'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
