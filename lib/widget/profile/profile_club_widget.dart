import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/profile/profile_joined_club.dart';
import '../../screen/club/club_screen.dart'; // 필요한 import 문 추가

class ProfileJoinedClub extends StatelessWidget {
  final List<JoinedClub> items;

  const ProfileJoinedClub({
    Key? key,
    required this.items,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Text(
          'No clubs joined yet.'); // Show a message if the list is empty
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
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
            itemCount: items.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () {
                  Get.toNamed(
                    '/clubs/',
                    arguments: {
                      "clubId": items[index].clubId,
                    },
                  );
                },
                child: SizedBox(
                  width: 100,
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(items[index].clubImage),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        items[index].clubName,
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
  }
}
