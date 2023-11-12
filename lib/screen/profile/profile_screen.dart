import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/screen/profile/profile_edit_screen.dart';

import '../../provider/Profile/profile_remote_provider.dart';
import '../../provider/profile/profile_local_provider.dart';
import '../../repository/profile/profile_repository.dart';
import '../../viewmodel/profile/profile_viewmodel.dart';
import '../../widget/base/default_appbar.dart';
import '../../widget/profile/profile_club_widget.dart';
import '../../widget/profile/profile_user_info_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final ProfileViewModel _profileViewModel;

  @override
  void initState() {
    super.initState();
    // User 및 joinedClubs 초기화
    _profileViewModel = Get.put<ProfileViewModel>(ProfileViewModel(
      profileRepository: ProfileRepository(
        profileLocalProvider: Get.put(ProfileLocalProvider()),
        profileRemoteProvider: Get.put(ProfileRemoteProvider()),
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppBar(
          title: "마이페이지",
        ),
      ),
      body: Column(
        children: [
          ProfileUserInfo(user: _profileViewModel.user!),
          const SizedBox(height: 15),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: ListView(
                children: [
                  const SizedBox(height: 5),
                  ProfileJoinedClub(items: _profileViewModel.joinedClubs),
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
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
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
              Get.to(() => const ProfileEditScreen());
            }),
            Obx(() => ListTile(
                  leading: const Icon(Icons.notifications, size: 24),
                  title: const Text(
                    '알림 설정',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Switch(
                    activeColor: const Color(0xFFFFFFFF),
                    activeTrackColor: const Color(0xFF5391FF),
                    value: _profileViewModel.isPushNotificationEnabled,
                    onChanged: _profileViewModel.togglePushNotification,
                  ),
                  onTap: () {},
                )),
            _buildVersionListTile(),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String label, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, size: 24),
      title: Text(label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          )),
      onTap: onTap,
    );
  }

  Widget _buildVersionListTile() {
    return const ListTile(
      leading: Icon(Icons.info_outline),
      title: Text(
        '버전 정보',
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w300,
        ),
      ),
      trailing: Text(
        'v 0.0.1',
        style: TextStyle(
          fontSize: 16.0,
          color: Colors.grey,
        ),
      ),
    );
  }
}
