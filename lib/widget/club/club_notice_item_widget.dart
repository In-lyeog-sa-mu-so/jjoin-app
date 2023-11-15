import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/club/club_notice.dart';

class ClubNoticeItem extends StatelessWidget {
  final int clubId;
  final ClubNotice item;
  const ClubNoticeItem({
    Key? key,
    required this.clubId,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (item.id != 0) {
      return Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: InkWell(
          onTap: () {
            Get.toNamed(
              "/clubs/notices",
              arguments: {
                "clubId": clubId,
                "noticeId": item.id,
              },
            );
          },
          child: Container(
            margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
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
                  height: 90,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                    ),
                  ),
                ),
                SizedBox.fromSize(size: const Size(10, 0)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        item.content.length > 100
                            ? "${item.content.substring(0, 80)}..."
                            : item.content,
                        style: const TextStyle(
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 9),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "최근 수정일: ",
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            item.date,
                            style: const TextStyle(
                              fontSize: 12,
                              height: 1.4,
                            ),
                          ),
                          SizedBox.fromSize(size: const Size(20, 0)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        height: 90,
        decoration: BoxDecoration(
          color: Colors.green[100],
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 1,
              offset: const Offset(0, 1), // 변경 가능한 값
            ),
          ],
        ),
        child: Center(
          child: Text(
            item.content,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black54,
            ),
          ),
        ),
      );
    }
  }
}
