import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:jjoin/model/club/club_home_info.dart';
import 'package:jjoin/widget/club/club_svg_info_widget.dart';

class ClubBigCardWidget extends StatelessWidget {
  final ClubHomeInfo item;
  const ClubBigCardWidget({required this.item, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // 마진 위 아래 10, 좌우 20
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 1), // 변경 가능한 값
          ),
        ],
        color: Colors.white,
      ),
      child: Column(
        children: [
          SizedBox.fromSize(size: const Size.fromHeight(10)),
          item.imageUuid.isEmpty
              ? SvgPicture.asset(
                  'assets/icons/icon_not_loading.svg',
                  width: 86,
                  height: 86,
                )
              : CircleAvatar(
                  radius: 43,
                  backgroundColor: Colors.blue[300],
                  backgroundImage: CachedNetworkImageProvider(item.imageUuid),
                  onBackgroundImageError: (exception, stackTrace) {
                    print(exception);
                  },
                ),
          SizedBox.fromSize(size: const Size.fromHeight(10)),
          Text(
            item.name,
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox.fromSize(size: const Size.fromHeight(10)),
          Text(
            item.introduction,
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox.fromSize(size: const Size.fromHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClubSvgInfoWidget(
                  title: item.leaderName,
                  imagePath: "assets/icons/icon_crown.svg"),
              SizedBox.fromSize(size: const Size(10, 0)),
              ClubSvgInfoWidget(
                  title: "${item.memberCnt}",
                  imagePath: "assets/icons/icon_people.svg"),
              SizedBox.fromSize(size: const Size(10, 0)),
              ClubSvgInfoWidget(
                  title: item.part.nameStr,
                  imagePath: "assets/icons/icon_dependency.svg"),
            ],
          ),
          SizedBox.fromSize(size: const Size.fromHeight(20)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox.fromSize(size: const Size(10, 0)),
              const Text(
                '공지',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox.fromSize(size: const Size(10, 0)),
              Text(
                item.recentNotice.length > 23
                    ? '${item.recentNotice.substring(0, 23)}...'
                    : item.recentNotice,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox.fromSize(size: const Size(10, 0)),
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: InkWell(
                    onTap: () {
                      Get.toNamed(
                        '/clubs',
                        arguments: {
                          "clubId": item.id,
                        },
                      );
                    },
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '상세보기',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        border: Border(
                            left: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                              width: 1,
                            ),
                            right: BorderSide(
                              color: Colors.grey.withOpacity(0.5),
                              width: 1,
                            )),
                      ),
                      child: const Center(
                        child: Text(
                          '공유하기',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )),
              ),
              Expanded(
                child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      padding: const EdgeInsets.symmetric(
                        vertical: 5,
                        horizontal: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Color(0xFFD9D9D9),
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: const Center(
                        child: Text(
                          '탈퇴하기',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                    )),
              )
            ],
          ),
        ],
      ),
    );
  }
}
