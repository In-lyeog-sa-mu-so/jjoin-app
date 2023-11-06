// ProfileEditScreen.dart 파일
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../model/profile_user.dart';
import '../repository/profile_repository.dart';

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
    _descriptionController = TextEditingController(text: user.introduction); // Initialize with user introduction
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 80,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: AssetImage(user.profileImageUuid)
              ),
            ),
            const SizedBox(height: 20),
            Text(
              user.name,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
            ),
            Text(user.major,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '자기소개',
                border: OutlineInputBorder(),
              ),
              maxLines: null,
              enabled: _isEditingText,
            ),

            const SizedBox(height: 20),
            Row( // Add this Row widget
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
                      print('User Introduction: ${_descriptionController.text}');
                      setState(() {
                        _isEditingText = false;
                      });
                      // TODO: Implement the logic to save these changes
                    } else {
                      // If we're not in edit mode, then "Save" might prompt the user to edit first
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
    );
  }
}