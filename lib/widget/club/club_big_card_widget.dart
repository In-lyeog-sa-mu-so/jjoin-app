import 'package:flutter/material.dart';
import 'package:jjoin/widget/club/club_info_widget.dart';

class ClubBigCardWidget extends StatelessWidget {
  const ClubBigCardWidget({super.key});

  final String _notiInfo = "2023년 할로윈 파티 일일호프 행사 관련 준비 공지";

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
          Container(
            width: 86,
            height: 86,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(43),
              image: const DecorationImage(
                image: NetworkImage(
                    'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox.fromSize(size: const Size.fromHeight(10)),
          Text(
            '동아리 이름',
            style: Theme.of(context).textTheme.headline6,
          ),
          SizedBox.fromSize(size: const Size.fromHeight(10)),
          Text(
            '동아리 소개',
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox.fromSize(size: const Size.fromHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClubInfoWidget(
                  title: "김태욱", imagePath: "assets/icons/icon_profile_24.svg"),
              SizedBox.fromSize(size: const Size(5, 0)),
              ClubInfoWidget(
                  title: "38", imagePath: "assets/icons/icon_profile_24.svg"),
              SizedBox.fromSize(size: const Size(5, 0)),
              ClubInfoWidget(
                  title: "컴퓨터공학과",
                  imagePath: "assets/icons/icon_profile_24.svg"),
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
                _notiInfo.length > 23
                    ? '${_notiInfo.substring(0, 23)}...'
                    : _notiInfo,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              SizedBox.fromSize(size: const Size(10, 0)),
            ],
          ),
          SizedBox.fromSize(size: const Size.fromHeight(10)),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
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
                        // 왼쪽 아래만 10
                        borderRadius: const BorderRadius.only(
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
