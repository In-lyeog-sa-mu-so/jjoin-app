import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/repository/Profile/profile_repository.dart';
import 'package:jjoin/screen/profile_edit_screen.dart';
import 'package:jjoin/widget/profile/profile_club_widget.dart';
import 'package:jjoin/widget/profile/profile_user_info_widget.dart';

import '../model/profile/profile_user.dart';
import 'club_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isPushNotificationEnabled = false;
  late User user;
  List<JoinedClub> joinedClubs = [];
  late Future<List<JoinedClub>> items;

  @override
  void initState() {
    super.initState();
    // User 및 joinedClubs 초기화
    user = ProfileRepository.getDummyUser();
    joinedClubs = ProfileRepository.getDummyClubs();
    // _loadItems 호출로 _items 초기화
    items = _loadItems();
  }

  Future<List<JoinedClub>> _loadItems() async {
    return joinedClubs;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: AppBar(
        title: const Text(
          'JJoin',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: true,
        leadingWidth: 90,
      ),
      body: Column(
        children: [
          ProfileUserInfo(user: user),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 0.5,
                    blurRadius: 1,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: ListView(
                children: [
                  const SizedBox(height: 5),
                  ProfileJoinedClub(items: items),
                  _buildOptions(context),
                  SizedBox(height: MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOptions(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: const Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            _buildOptionItem(Icons.person, '프로필 편집', () {
              const userDescription = " ";
              Get.to(() => const ProfileEditScreen(
                    userDescription: userDescription,
                  ));
            }),
            ListTile(
              leading: const Icon(Icons.notifications, size: 20), // 알람 아이콘 추가
              title: const Text(
                '앱 푸시 알림',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w300,
                ),
              ),
              trailing: Switch(
                value: _isPushNotificationEnabled,
                onChanged: (bool value) {
                  setState(() {
                    _isPushNotificationEnabled = value;
                  });
                },
              ),
              onTap: () {}, // ListTile의 onTap을 비활성화
            ),
            _buildVersionListTile(),
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

  Widget _buildVersionListTile() {
    return const ListTile(
      leading: Icon(Icons.info_outline),
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
}
