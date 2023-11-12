import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/profile/profile_user.dart';
import '../../screen/club_screen.dart'; // 필요한 import 문 추가

class ProfileJoinedClub extends StatelessWidget {
  final Future<List<JoinedClub>> items;

  const ProfileJoinedClub({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<JoinedClub>>(
      future: items,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // 로딩 인디케이터 표시
        } else if (snapshot.hasError) {
          return const Text('Failed to load data.'); // 데이터 로드 실패 시 메시지 표시
        } else if (snapshot.hasData) {
          var clubs = snapshot.data!;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: Text(
                  '가입한 동아리',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: clubs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        Get.to(() => const ClubScreen(),
                            arguments: clubs[index].clubId);
                      },
                      child: SizedBox(
                        width: 100,
                        child: Column(
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage:
                                  AssetImage(clubs[index].clubImage),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              clubs[index].clubName,
                              style: const TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } else {
          return const Text('No data.');
        }
      },
    );
  }
}
