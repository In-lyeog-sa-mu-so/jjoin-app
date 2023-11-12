import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../model/club/club_recommend.dart';
import 'club_info_widget.dart';
import 'club_tag_widget.dart';

class ClubRecommendItem extends StatelessWidget {
  final ClubRecommend item;
  const ClubRecommendItem({required this.item, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: InkWell(
        onTap: () {
          Get.toNamed('/clubs');
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 10, 15, 10),
            child: Row(
              children: [
                item.imageURL.isEmpty
                    ? SvgPicture.asset(
                        'assets/icons/icon_not_loading.svg',
                        width: 96,
                        height: 96,
                      )
                    : CircleAvatar(
                        radius: 48,
                        backgroundColor: Colors.blue[300],
                        backgroundImage:
                            CachedNetworkImageProvider(item.imageURL),
                      ),
                SizedBox.fromSize(size: const Size(20, 0)),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name.length > 12
                          ? '${item.name.substring(0, 12)}...'
                          : item.name,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      item.description.length > 20
                          ? '${item.description.substring(0, 20)}...'
                          : item.description,
                      style: const TextStyle(
                        fontSize: 13,
                      ),
                    ),
                    SizedBox.fromSize(size: const Size(0, 5)),
                    Row(
                      children: [
                        ClubInfoWidget(
                            title: item.memberCnt.toString(),
                            imagePath: "assets/icons/icon_profile_24.svg"),
                        SizedBox.fromSize(size: const Size(5, 0)),
                        ClubInfoWidget(
                            title: item.part.nameStr,
                            imagePath: "assets/icons/icon_profile_24.svg"),
                      ],
                    ),
                    SizedBox.fromSize(size: const Size(0, 5)),
                    // 태그 추가 List 타입으로 받아서 for문으로 돌리기
                    Row(
                      children: [
                        for (int i = 0; i < 2; i++)
                          ClubTagWidget(title: item.tags[i]),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
