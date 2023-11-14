import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jjoin/repository/club/club_repository.dart';
import 'package:jjoin/viewmodel/home/home_viewmodel.dart';
import 'package:jjoin/widget/base/default_appbar.dart';
import 'package:jjoin/widget/club/club_able_event_item_widget.dart';
import 'package:jjoin/widget/club/club_recommend_item_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_provider.dart';
import '../../widget/club/club_big_card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final PageController _pageController;
  late final HomeViewModel _viewModel;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController(initialPage: 0, viewportFraction: 0.922);
    _viewModel = Get.put<HomeViewModel>(HomeViewModel(
      clubRepository: ClubRepository(
        clubLocalProvider: Get.put(ClubLocalProvider()),
        clubProvider: Get.put(ClubProvider()),
      ),
    ));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
    _viewModel.dispose();
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
          Obx(() => _viewModel.isLoadingUserJoinClubs
              ? const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 310,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: SizedBox(
                    height: 310,
                    child: PageView.builder(
                      controller: _pageController,
                      onPageChanged: (int index) {
                        setState(() {});
                      },
                      itemCount: _viewModel.userJoinClubs.length,
                      itemBuilder: (context, index) {
                        return ClubBigCardWidget(
                          item: _viewModel.userJoinClubs[index],
                        );
                      },
                    ),
                  ),
                )),
          Obx(() => _viewModel.isLoadingUserJoinClubs
              ? const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30,
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                  sliver: SliverToBoxAdapter(
                    child: Center(
                      child: SmoothPageIndicator(
                        controller: _pageController, // PageController
                        count: _viewModel.userJoinClubs.length,
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
                )),
          Obx(() => _viewModel.isLoadingUserSchedules
              ? const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30,
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ClubAbleEventItem(
                        item: _viewModel.userSchedules[index],
                        onAgree: (int id) {
                          _viewModel.updateSchedule(id, false).then(
                                (isSuccess) => {
                                  if (!isSuccess)
                                    {
                                      Get.snackbar(
                                        "통신 오류",
                                        "동아리 일정 수락에 실패했습니다.",
                                        duration: const Duration(
                                            seconds: 1, milliseconds: 500),
                                        snackPosition: SnackPosition.TOP,
                                        margin: const EdgeInsets.only(
                                            top: 30, left: 20, right: 20),
                                      )
                                    }
                                },
                              );
                        },
                        onDisagree: (int id) {
                          _viewModel.updateSchedule(id, false).then(
                                (isSuccess) => {
                                  if (!isSuccess)
                                    {
                                      Get.snackbar(
                                        "통신 오류",
                                        "동아리 일정 수락에 실패했습니다.",
                                        duration: const Duration(
                                            seconds: 1, milliseconds: 500),
                                        snackPosition: SnackPosition.TOP,
                                        margin: const EdgeInsets.only(
                                            top: 30, left: 20, right: 20),
                                      )
                                    }
                                },
                              );
                        },
                      );
                    },
                    childCount: _viewModel.userSchedules.length > 5
                        ? 5
                        : _viewModel.userSchedules.length,
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
          Obx(() => _viewModel.isLoadingRecommendClubsForUser
              ? const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 30,
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      return ClubRecommendItem(
                        item: _viewModel.userRecommendClubs[index],
                      );
                    },
                    childCount: _viewModel.userRecommendClubs.length,
                  ),
                )),
        ],
      ),
    );
  }
}
