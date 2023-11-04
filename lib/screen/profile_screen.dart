import 'package:flutter/material.dart';
import 'dart:io'; // Used for File class
import 'package:image_picker/image_picker.dart';
import 'package:jjoin/screen/profile_edit_screen.dart'; // You need to add image_picker to your pubspec.yaml

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage; // This will hold the uploaded image file
  bool _isPushNotificationEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        backgroundColor: Colors.transparent,
        elevation: 0, // No shadow
      ),
      body: ListView(
        children: [
          _buildTopBanner(context),
          const SizedBox(height: 20),
          _buildScrollingCards(context),
          const SizedBox(height: 20),
          _buildOptions(context),
        ],
      ),
    );
  }

  Widget _buildTopBanner(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      alignment: Alignment.center,
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey.shade300,
            backgroundImage: _profileImage != null
                ? FileImage(_profileImage!) as ImageProvider // FileImage에 캐스팅하여 에러 해결
                : AssetImage('assets/icons/icon_profile_24.svg'), // 기본 아이콘 이미지 경로를 확인하세요.
          ),
          const SizedBox(height: 8),
          Text(
            '홍길동',
            style: Theme.of(context).textTheme.headline6,
          ),
          Text('동국대학교 컴퓨터공학과'),
        ],
      ),
    );
  }




  Widget _buildOptions(BuildContext context) {
    return Column(
      children: [
        _buildOptionItem(Icons.person, '프로필 편집', () {
          // '자기소개' 부분을 프로필 편집 화면으로 넘깁니다.
          // DB에서 가져온다고 가정한 사용자의 '자기소개' 내용입니다.
          const userDescription = " ";
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfileEditScreen(
                userDescription: userDescription,
              ),
            ),
          );
        }),
        // 푸시 알림 설정 스위치 추가
        SwitchListTile(
          title: const Text('앱 푸시 알림'),
          value: _isPushNotificationEnabled,
          onChanged: (bool value) {
            // 알림 상태를 변경하는 로직 (예: 상태 저장, 서버에 업데이트 등)
            setState(() {
              _isPushNotificationEnabled = value;
            });
          },
          secondary: const Icon(Icons.notifications),
        ),
        // 앱 버전 표시 추가
        ListTile(
          title: const Text('앱 버전'),
          subtitle: const Text('v0.0.1'), // 여기서 실제 앱 버전을 표시합니다.
          // secondary: Icon(Icons.info_outline), // 아이콘을 추가하고 싶다면 주석 해제
        ),
      ],
    );
  }

  Widget _buildOptionItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      onTap: onTap,
    );
  }
  late Future<List<String>> _items; // 여기서는 예시로 String 리스트를 사용

  @override
  void initState() {
    super.initState();
    _items = _loadItems(); // 데이터베이스에서 아이템을 불러오는 함수를 호출
  }

  Future<List<String>> _loadItems() async {
    // 여기서 데이터베이스에서 아이템을 불러오는 로직을 구현
    // 임시로 몇 개의 아이템을 생성하여 반환
    await Future.delayed(Duration(seconds: 2)); // 가상의 로딩 시간
    return List.generate(10, (index) => '아이템 $index'); // 가상의 데이터
  }

  Widget _buildScrollingCards(BuildContext context) {
    return FutureBuilder<List<String>>(
      future: _items,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 데이터를 불러오는 동안 로딩 인디케이터를 표시합니다.
        } else if (snapshot.hasError) {
          return Text('데이터를 불러오는데 실패했습니다.');
        } else if (snapshot.hasData) {
          var items = snapshot.data!;
          return Container(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length, // 불러온 데이터의 개수로 설정
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    // TODO: 아이템 클릭 시 필요한 동작을 구현
                    print('${items[index]} 클릭됨');
                  },
                  child: Container(
                    width: 100,
                    child: Card(
                      child: Center(
                        child: Text(items[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return Text('데이터가 없습니다.');
        }
      },
    );
  }
}
