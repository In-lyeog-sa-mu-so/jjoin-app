import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../model/profile/profile_joined_club.dart';

class ProfileJoinedClub extends StatelessWidget {
  final List<JoinedClub> clubs;

  const ProfileJoinedClub({
    Key? key,
    required this.clubs,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (clubs[0].id != 0) {
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
              itemCount: clubs.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.toNamed(
                      '/clubs/',
                      arguments: {
                        "clubId": clubs[index].id,
                      },
                    );
                  },
                  child: SizedBox(
                    width: 100,
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage: CachedNetworkImageProvider(
                              clubs[index].clubImageUuid),
                        ),
                        const SizedBox(height: 6),
                        //clubs[index].name 길이가 6이상이면 ...으로 표시
                        clubs[index].name.length > 6
                            ? Text(
                                clubs[index].name.substring(0, 6) + "...",
                                style: const TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.w500),
                              )
                            :
                            //6이하면 그대로 표시
                            Text(
                                clubs[index].name,
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
      return SizedBox(
        height: 120,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                clubs[0].name,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
