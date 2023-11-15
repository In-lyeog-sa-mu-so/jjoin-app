import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';

import '../../provider/profile/profile_local_provider.dart';
import '../../provider/profile/profile_provider.dart';
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
  void dispose() {
    super.dispose();
    _descriptionController.dispose();
  }

  @override
  void initState() {
    super.initState();
    _profileEditViewModel = Get.put<ProfileEditViewModel>(ProfileEditViewModel(
      profileRepository: ProfileRepository(
        profileLocalProvider: Get.put(ProfileLocalProvider()),
        profileProvider: Get.put(ProfileProvider()),
      ),
    ));
    _descriptionController =
        TextEditingController(text: Get.arguments['introduction']);
  }

  Future<void> _pickImage() async {
    XFile? pickedFile = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      _profileEditViewModel.saveImage(File(pickedFile.path));
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
                  Obx(() {
                    if (!_profileEditViewModel.isLoadingUserInfo) {
                      return GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 60,
                          backgroundImage: CachedNetworkImageProvider(
                              _profileEditViewModel.userInfo.profileImageUuid),
                        ),
                      );
                    } else {
                      //위의 circleavatar와 같은 크기로
                      return const SizedBox(
                        width: 120,
                        height: 120,
                        child: CircularProgressIndicator(),
                      );
                    }
                  }),
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
                              Get.arguments['name'],
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('전공: ${Get.arguments['major']}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('학번: ${Get.arguments['id']}',
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
