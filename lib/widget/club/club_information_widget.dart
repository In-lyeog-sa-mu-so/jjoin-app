import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/screen/application/club_application_screen.dart';

import '../../model/club/club_model.dart';
import 'club_svg_info_widget.dart';

class ClubInformation extends StatelessWidget {
  final ClubModel clubModel;
  final List<String> _tags = [
    "프로젝트",
    "프로젝트",
    "프로젝트",
  ];
  ClubInformation({required this.clubModel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 235,
          child: Stack(
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  // 비율 맞춰서 이미지 넣기
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        clubModel.backgroundImageUrl),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 15,
                // 동그란 이미지 넣기
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      CachedNetworkImageProvider(clubModel.profileImageUrl),
                ),
              ),
              Positioned(
                top: 207,
                right: 15,
                child: Row(
                  children: [
                    for (var tag in clubModel.tags)
                      Container(
                        margin: const EdgeInsets.only(right: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey[300],
                        ),
                        child: Text(
                          tag,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ),
                  ],
                ),
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15, top: 5, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                clubModel.name,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox.fromSize(size: const Size(0, 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClubSvgInfoWidget(
                      title: clubModel.leaderName,
                      imagePath: "assets/icons/icon_crown.svg"),
                  SizedBox.fromSize(size: const Size(10, 0)),
                  ClubSvgInfoWidget(
                      title: clubModel.memberCnt.toString(),
                      imagePath: "assets/icons/icon_people.svg"),
                  SizedBox.fromSize(size: const Size(10, 0)),
                  ClubSvgInfoWidget(
                      title: clubModel.part.name,
                      imagePath: "assets/icons/icon_dependency.svg"),
                  SizedBox.fromSize(size: const Size(10, 0)),
                  const Text("개설일: ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    clubModel.createdDateStr,
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox.fromSize(size: Size(0, 5)),
              Text(
                clubModel.introduction,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox.fromSize(size: const Size(0, 5)),
              // _JoinedText 가운데 정렬
              Center(
                child: _JoinedText(
                  recentJoinedDate: clubModel.recentJoinedDate,
                  existRecentJoinedDate: clubModel.existRecentJoinedDate,
                  isRecruiting: clubModel.isRecruiting,
                ),
              ),
              const SizedBox(height: 10),
              // 지원하기 버튼
              Theme(
                data: ThemeData(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                ),
                child: InkWell(
                  onTap: () {
                    // 지원하기 버튼 클릭 시
                    Get.to(
                      () => const ClubApplicationScreen(),
                      arguments: {
                        "clubId": clubModel.id,
                      },
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: clubModel.isRecruiting
                          ? Colors.green[300]
                          : Colors.grey[300],
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Center(
                      child: Text(
                        "지원하기",
                        style: TextStyle(
                          fontSize: 16,
                          color: clubModel.isRecruiting
                              ? Colors.black54
                              : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _JoinedText extends StatelessWidget {
  final String recentJoinedDate;
  final bool existRecentJoinedDate;
  final bool isRecruiting;
  const _JoinedText({
    required this.recentJoinedDate,
    required this.existRecentJoinedDate,
    required this.isRecruiting,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (!existRecentJoinedDate) {
      return const Text(
        "아직 모집을 시작하지 않았어요ㅠㅠ",
        style: TextStyle(
          fontSize: 15,
          color: Colors.black38,
          fontWeight: FontWeight.bold,
        ),
      );
    } else {
      if (isRecruiting) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "모집 중  ",
              style: TextStyle(
                fontSize: 15,
                color: Colors.green,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "  $recentJoinedDate",
              style: const TextStyle(
                fontSize: 15,
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        );
      } else {
        return const Text(
          "모집이 마감되었어요ㅠㅠ",
          style: TextStyle(
            fontSize: 15,
            color: Colors.red,
            fontWeight: FontWeight.bold,
          ),
        );
      }
    }
  }
}
