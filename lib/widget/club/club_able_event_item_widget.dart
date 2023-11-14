import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:jjoin/model/club/club_schedule.dart';

class ClubAbleEventItem extends StatelessWidget {
  final ClubSchedule item;
  final Function onAgree;
  final Function onDisagree;
  const ClubAbleEventItem({
    Key? key,
    required this.item,
    required this.onAgree,
    required this.onDisagree,
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
              "/clubs/plan",
              arguments: {
                "clubId": item.clubId!,
                "scheduleId": item.id,
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
                  height: 80,
                  decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: const BorderRadius.only(
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
                    Text(
                      item.clubName!,
                      style: const TextStyle(
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 12,
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
                    onAgree(item.id);
                  },
                  child:
                      item.isParticipate == null || item.isParticipate == false
                          ? Opacity(
                              opacity: 0.3,
                              child: SvgPicture.asset(
                                'assets/icons/item_agree.svg',
                                width: 30,
                                height: 30,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/icons/item_agree.svg',
                              width: 30,
                              height: 30,
                            ),
                ),
                SizedBox.fromSize(size: const Size(15, 0)),
                InkWell(
                  onTap: () {
                    onDisagree(item.id);
                  },
                  child:
                      item.isParticipate == null || item.isParticipate == true
                          ? Opacity(
                              opacity: 0.3,
                              child: SvgPicture.asset(
                                'assets/icons/item_disagree.svg',
                                width: 30,
                                height: 30,
                              ),
                            )
                          : SvgPicture.asset(
                              'assets/icons/item_disagree.svg',
                              width: 30,
                              height: 30,
                            ),
                ),
                SizedBox.fromSize(size: const Size(10, 0)),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container(
        margin: const EdgeInsets.fromLTRB(20, 8, 20, 8),
        height: 80,
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
