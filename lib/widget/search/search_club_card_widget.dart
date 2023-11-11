import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/SearchClub/search_club.dart';

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

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: isRecruiting ? Colors.green.shade300 : Colors.red.shade300,
            width: 8,
          ),
        ),
      ),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                club.clubName,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              const Divider(), // clubName과 아래 행을 구분하는 줄
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 이미지 표시 부분 (임시로 placeholder 이미지 사용)
                  Image.asset(
                      club.profileImageUuid.isNotEmpty
                          ? club.profileImageUuid
                          : 'assets/images/dgu_image.png',
                      height: 80,
                      width: 80),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          club.dependent ?? '',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
