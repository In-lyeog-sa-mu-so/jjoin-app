import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../model/club/club_schedule.dart';

class ClubPlanItem extends StatelessWidget {
  final ClubSchedule item;
  const ClubPlanItem({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed("/clubs/plan");
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
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.calendar_today,
                          size: 14,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          item.date,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "참가",
                          style: (item.isParticipate == null ||
                                  item.isParticipate == false)
                              ? const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                )
                              : const TextStyle(
                                  fontSize: 12,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                        ),
                        SizedBox.fromSize(size: const Size(10, 0)),
                        Text(
                          "불참",
                          style: (item.isParticipate == null ||
                                  item.isParticipate == true)
                              ? const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                )
                              : const TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  height: 1.4,
                                ),
                        ),
                        SizedBox.fromSize(size: const Size(20, 0)),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
