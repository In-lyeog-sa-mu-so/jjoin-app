import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/repository/club/club_repository.dart';
import 'package:jjoin/viewmodel/home/home_viewmodel.dart';
import 'package:jjoin/widget/base/default_appbar.dart';
import 'package:jjoin/widget/club/club_event_item_widget.dart';
import 'package:jjoin/widget/club/club_recommend_item_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../model/base/e_club_part.dart';
import '../../model/club/club_home_info.dart';
import '../../model/club/club_recommend.dart';
import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_remote_provider.dart';
import '../../widget/club/club_big_card_widget.dart';
import 'package:flutter/foundation.dart' as foundation;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  late final HomeViewModel _homeViewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.922);
    _homeViewModel = Get.put<HomeViewModel>(HomeViewModel(
      clubRepository: ClubRepository(
        clubLocalProvider: Get.put(ClubLocalProvider()),
        clubRemoteProvider: Get.put(ClubRemoteProvider()),
      ),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    _homeViewModel.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppBar(
          title: "JJoin",
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: foundation.defaultTargetPlatform ==
                      foundation.TargetPlatform.iOS
                  ? 307
                  : 310,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {});
                },
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ClubBigCardWidget(
                    item: ClubHomeInfo(
                      id: 1,
                      name: "컴퓨터공학과 학생회",
                      description: "컴퓨터공학과 학생회입니다.",
                      part: EClubPart.DEPARTMENT,
                      memberCnt: 10,
                      imageURL:
                          "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                      leaderName: "김태욱",
                      recentNotice: "컴퓨터공학과 학생회입니다.",
                    ),
                  );
                },
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(25, 10, 0, 10),
            sliver: SliverToBoxAdapter(
              child: Center(
                child: SmoothPageIndicator(
                  controller: _pageController, // PageController
                  count: 3,
                  // forcing the indicator to use a specific direction
                  textDirection: TextDirection.ltr,
                  effect: const WormEffect(
                    dotColor: Color(0xFFE5E5E5),
                    activeDotColor: Color(0xFF56D57F),
                    dotHeight: 10,
                    dotWidth: 10,
                    spacing: 10,
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ClubEventItem(item: _homeViewModel.schedules[index]);
              },
              childCount: _homeViewModel.schedules.length,
            ),
          ),
          const SliverToBoxAdapter(
              child: Padding(
            // 왼쪽만 패딩
            padding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
            child: Text(
              "추천 동아리",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return ClubRecommendItem(
                    item: ClubRecommend(
                  id: 1,
                  name: "컴퓨터공학과 학생회",
                  description: "컴퓨터공학과 학생회입니다.",
                  part: EClubPart.DEPARTMENT,
                  memberCnt: 10,
                  imageURL:
                      "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
                  tags: ["친목", "학술"],
                ));
              },
              childCount: 3,
            ),
          ),
        ],
      ),
    );
  }
}
