import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/search/search_club.dart';

class ClubCard extends StatelessWidget {
  const ClubCard({
    super.key,
    required this.club,
  });

  final SearchClub club;

  @override
  Widget build(BuildContext context) {
    final bool isRecruiting = club.isFinished;
    String recruitingText = isRecruiting
        ? '모집 중 (${DateFormat('MM.dd').format(club.startDate)}~${DateFormat('MM.dd').format(club.endDate)})'
        : '모집 마감';

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.white,
      elevation: 0.6,
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
                  backgroundImage: club.profileImageUuid.isNotEmpty
                      ? AssetImage(club.profileImageUuid)
                      : const AssetImage('assets/images/dgu_image.png'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${club.part.nameStr} 동아리',
                        style: const TextStyle(fontSize: 16.0),
                      ),
                      Text(
                        recruitingText,
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: isRecruiting ? Colors.green : Colors.red,
                        ),
                      ),
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
