import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:jjoin/repository/profile_repository.dart';
import 'package:jjoin/screen/profile_edit_screen.dart';

import '../model/profile_user.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;
  bool _isPushNotificationEnabled = false;
  late User user;

  @override
  void initState() {
    super.initState();
    _items = _loadItems();
    user = ProfileRepository.getDummyUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('프로필'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildTopBanner(context),
          SizedBox(height: 15),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white, // Set the background color of the container
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: ListView(
                children: [
                  const SizedBox(height: 5),
                  _buildScrollingCards(context),
                  const SizedBox(height: 10),
                  _buildOptions(context),
                  SizedBox(height: MediaQuery.of(context).padding.bottom), // To ensure it extends to the bottom of the screen
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildTopBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color of the container
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10), // Round the corners slightly
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage(user.profileImageUuid),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text('${user.name}',
                            style: const TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('전공: ${user.major}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('학번: ${user.studentId.toString()}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Text(
              user.introduction,
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // Set the background color of the container
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: Offset(0, 0), // changes position of shadow
            ),
          ],
          borderRadius: BorderRadius.circular(10), // Round the corners slightly
        ),
        child: Column(
          children: [
            _buildOptionItem(Icons.person, '프로필 편집', () {
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
            SwitchListTile(
              title: const Text('앱 푸시 알림',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              value: _isPushNotificationEnabled,
              onChanged: (bool value) {
                setState(() {
                  _isPushNotificationEnabled = value;
                });
              },
              secondary: const Icon(Icons.notifications,
              size: 20,
              ),
            ),
            _buildVersionListTile(), // Add the version list tile here
          ],
        ),
      ),
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

  Widget _buildVersionListTile() {
    return const ListTile(
      leading: Icon(Icons.info_outline), // Replace with your preferred icon
      title: Text(
        '앱 버전',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      trailing: Text(
        'v0.0.1',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
      ),
    );
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
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0,),
            child: Container(
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
            ),
          );
        } else {
          return Text('데이터가 없습니다.');
        }
      },
    );
  }
}
