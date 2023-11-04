// ProfileEditScreen.dart 파일
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

  @override
  void initState() {
    super.initState();
    _descriptionController = TextEditingController(text: widget.userDescription);
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
              onTap: _pickImage, // 이미지를 탭했을 때 _pickImage 메소드를 호출합니다.
              child: CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey.shade300,
                backgroundImage: _profileImage != null
                    ? FileImage(_profileImage!) as ImageProvider<Object> // 타입 캐스팅 추가
                    : const AssetImage('assets/icons/icon_profile_24.svg'), // 'const' 추가하여 이미지 경로 명시
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              '홍길동',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text('동국대학교 컴퓨터공학과'),
            const SizedBox(height: 20),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: '자기소개',
              ),
              maxLines: null, // 무한 입력 가능
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // TODO: 수정 사항 저장 로직 구현
                },
                child: const Text('저장하기'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
