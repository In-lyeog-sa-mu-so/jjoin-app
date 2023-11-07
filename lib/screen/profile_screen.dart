import 'package:flutter/material.dart';
import 'package:jjoin/repository/Profile/profile_repository.dart';
import 'package:jjoin/screen/profile_edit_screen.dart';

import '../model/profile/profile_user.dart';
import 'detail_club_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isPushNotificationEnabled = false;
  late User user;
  List<JoinedClub> joinedClubs = [];
  late Future<List<JoinedClub>> _items;

  @override
  void initState() {
    super.initState();
    // User 및 joinedClubs 초기화
    user = ProfileRepository.getDummyUser();
    joinedClubs = ProfileRepository.getDummyClubs();
    // _loadItems 호출로 _items 초기화
    _items = _loadItems();
  }

  Future<List<JoinedClub>> _loadItems() async {
    return joinedClubs;
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
                  _buildScrollingCards(context),
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

  Widget _buildTopBanner(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(user.profileImageUuid),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            user.name,
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
                              )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5),
                          child: Text('학번: ${user.studentId.toString()}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                              )),
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
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 1,
              offset: Offset(0, 0),
            ),
          ],
          borderRadius: BorderRadius.circular(10),
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
              title: const Text(
                '앱 푸시 알림',
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
              secondary: const Icon(
                Icons.notifications,
                size: 20,
              ),
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

  Widget _buildScrollingCards(BuildContext context) {
    return FutureBuilder<List<JoinedClub>>(
      future: _items,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // 로딩 인디케이터 표시
        } else if (snapshot.hasError) {
          return Text('Failed to load data.'); // 데이터 로드 실패 시 메시지 표시
        } else if (snapshot.hasData) {
          var clubs = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Container(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: clubs.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      // 클릭 시 DetailClubScreen으로 이동하며 clubId를 전달합니다.
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailClubScreen(clubId: clubs[index].clubId),
                        ),
                      );
                    },
                    child: Container(
                      width: 100,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                NetworkImage(clubs[index].clubImage),
                          ),
                          SizedBox(height: 6),
                          Text(
                            clubs[index].clubName,
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return Text('No data.');
        }
      },
    );
  }
}
