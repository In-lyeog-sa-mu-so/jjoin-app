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
              height: 310,
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (int index) {
                  setState(() {});
                },
                itemCount: _homeViewModel.clubHomeInfos.length,
                itemBuilder: (context, index) {
                  return ClubBigCardWidget(
                    item: _homeViewModel.clubHomeInfos[index],
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
          Obx(() => SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return ClubEventItem(
                      item: _homeViewModel.schedules[index],
                      onAgree: (int id) {
                        if (!_homeViewModel.updateSchedule(id, true)) {
                          Get.snackbar(
                            "통신 오류",
                            "동아리 일정 수락에 실패했습니다.",
                            duration:
                                const Duration(seconds: 1, milliseconds: 500),
                            snackPosition: SnackPosition.TOP,
                            margin: const EdgeInsets.only(
                                top: 30, left: 20, right: 20),
                          );
                        }
                      },
                      onDisagree: (int id) {
                        if (!_homeViewModel.updateSchedule(id, false)) {
                          Get.snackbar(
                            "통신 오류",
                            "동아리 일정 수락에 실패했습니다.",
                            duration:
                                const Duration(seconds: 1, milliseconds: 500),
                            snackPosition: SnackPosition.TOP,
                            margin: const EdgeInsets.only(
                                top: 30, left: 20, right: 20),
                          );
                        }
                      },
                    );
                  },
                  childCount: _homeViewModel.schedules.length > 3
                      ? 3
                      : _homeViewModel.schedules.length,
                ),
              )),
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
                  item: _homeViewModel.clubRecommends[index],
                );
              },
              childCount: _homeViewModel.clubRecommends.length > 3
                  ? 3
                  : _homeViewModel.clubRecommends.length,
            ),
          ),
        ],
      ),
    );
  }
}
