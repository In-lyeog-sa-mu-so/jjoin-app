import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'club_svg_info_widget.dart';

class ClubInformation extends StatelessWidget {
  final List<String> _tags = [
    "프로젝트",
    "프로젝트",
    "프로젝트",
  ];
  ClubInformation({super.key});

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
                decoration: const BoxDecoration(
                  // 비율 맞춰서 이미지 넣기
                  image: DecorationImage(
                    image: CachedNetworkImageProvider(
                        "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
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
                  backgroundImage: CachedNetworkImageProvider(
                      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                ),
              ),
              Positioned(
                top: 207,
                right: 15,
                child: Row(
                  children: [
                    for (var tag in _tags)
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
                "FC 세미콜론",
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
                      title: "강우빈", imagePath: "assets/icons/icon_crown.svg"),
                  SizedBox.fromSize(size: const Size(10, 0)),
                  ClubSvgInfoWidget(
                      title: "38", imagePath: "assets/icons/icon_people.svg"),
                  SizedBox.fromSize(size: const Size(10, 0)),
                  ClubSvgInfoWidget(
                      title: "학과",
                      imagePath: "assets/icons/icon_dependency.svg"),
                  SizedBox.fromSize(size: const Size(10, 0)),
                  Text("개설일: ",
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      )),
                  Text(
                    "2010년 8월",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox.fromSize(size: Size(0, 5)),
              Text(
                "안녕하세요! 동국대학교 컴퓨터 공학과 소모임 FC 세미콜론입니다. 1달에 4-6회씩 축구, 풋살을 하며 학교 정기 대회도 출전할 계획입니다. 많은 관심 부탁드립니다!",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
              SizedBox.fromSize(size: const Size(0, 5)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "최근 모집기간",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "  2021년 3월 1일 ~ 2021년 3월 31일",
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
