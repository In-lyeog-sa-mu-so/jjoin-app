import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/search/search_club.dart';
import '../club/club_svg_info_widget.dart';

class ClubCard extends StatelessWidget {
  const ClubCard({
    super.key,
    required this.club,
  });

  final SearchClub club;

  @override
  Widget build(BuildContext context) {
    final bool isRecruiting = !club.isFinished;
    String recruitingText = isRecruiting
        ? '모집 중 (${DateFormat('MM.dd').format(club.startDate)}~${DateFormat('MM.dd').format(club.endDate)})'
        : '모집 마감';

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey.withOpacity(0.5)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 1), // 변경 가능한 값
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              club.clubName,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const Divider(), // clubName과 아래 행을 구분하는 줄
            const SizedBox(height: 10),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 40,
                  backgroundColor: club.profileImageUuid.isNotEmpty
                      ? Colors.transparent
                      : Colors.blue[300],
                  backgroundImage: club.profileImageUuid.isNotEmpty
                      ? CachedNetworkImageProvider(club.profileImageUuid)
                      : null,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${club.dependent.nameStr} 동아리',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 4),
                      Text(
                        recruitingText,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: club.isFinished ? Colors.red : Colors.green,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ClubSvgInfoWidget(
                            title: club.leaderName,
                            imagePath: 'assets/icons/icon_crown.svg',
                          ),
                          const SizedBox(width: 10),
                          ClubSvgInfoWidget(
                            title: club.userNumber.toString(),
                            imagePath: 'assets/icons/icon_people.svg',
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              club.introduction,
              style: const TextStyle(fontSize: 16.0),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
