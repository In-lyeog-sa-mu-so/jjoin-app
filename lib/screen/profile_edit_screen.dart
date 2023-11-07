import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../model/profile/profile_user.dart';
import '../repository/Profile/profile_repository.dart';

class ProfileEditScreen extends StatefulWidget {
  final String userDescription;

  const ProfileEditScreen({
    super.key,
    required this.userDescription,
  });

  @override
  _ProfileEditScreenState createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  late TextEditingController _descriptionController;
  File? _profileImage;
  late User user;
  bool _isEditingText = false;

  @override
  void initState() {
    super.initState();
    user = ProfileRepository.getDummyUser() as User;
    _descriptionController = TextEditingController(text: user.introduction);
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
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text('프로필 편집'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                      backgroundImage: AssetImage(user.profileImageUuid),
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
                              user.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('전공: ${user.major}',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w300,
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text('학번: ${user.studentId.toString()}',
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
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    TextField(
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
                        color: _isEditingText
                            ? Colors.black
                            : Colors.grey.shade600,
                      ),
                      maxLines: 15,
                      enabled: _isEditingText,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _isEditingText = true;
                            });
                          },
                          child: const Text('수정하기'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_isEditingText) {
                              print('Profile Image: ${_profileImage?.path}');
                              print(
                                  'User Introduction: ${_descriptionController.text}');
                              setState(() {
                                _isEditingText = false;
                              });
                              // TODO: Implement the logic to save these changes
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text('수정하기 버튼을 눌러 수정하세요.'),
                                ),
                              );
                            }
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
