import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:jjoin/model/club/club_schedule.dart';

class ClubEventItem extends StatelessWidget {
  final ClubEvent item;
  const ClubEventItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(25, 8, 25, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 1), // 변경 가능한 값
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.red[100],
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          SizedBox.fromSize(size: const Size(10, 0)),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    item.date,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          InkWell(
            onTap: () {
              if (kDebugMode) {
                print("agree");
              }
            },
            child: SvgPicture.asset(
              'assets/icons/item_agree.svg',
              width: 30,
              height: 30,
            ),
          ),
          SizedBox.fromSize(size: const Size(15, 0)),
          InkWell(
            onTap: () {
              if (kDebugMode) {
                print("disagree");
              }
            },
            child: SvgPicture.asset(
              'assets/icons/item_disagree.svg',
              width: 30,
              height: 30,
            ),
          ),
          SizedBox.fromSize(size: const Size(10, 0)),
        ],
      ),
    );
  }
}
