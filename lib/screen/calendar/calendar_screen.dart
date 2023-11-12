import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:jjoin/widget/base/default_appbar.dart';

import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_remote_provider.dart';
import '../../repository/club/club_repository.dart';
import '../../viewmodel/calendar/calendar_viewmodel.dart';
import '../../widget/calendar/schedule_calendar.dart';
import '../../widget/club/club_able_event_item_widget.dart';
import '../../widget/club/club_disable_event_item_widget.dart';

class CalendarScreen extends StatelessWidget {
  final CalendarViewModel _viewModel =
      Get.put<CalendarViewModel>(CalendarViewModel(
    clubRepository: ClubRepository(
      clubLocalProvider: Get.put(ClubLocalProvider()),
      clubRemoteProvider: Get.put(ClubRemoteProvider()),
    ),
  ));
  CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppBar(
          title: "일정",
        ),
      ),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ScheduleCalendar(
                viewModel: _viewModel,
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                margin: EdgeInsets.only(top: 10),
                width: double.infinity,
                height: 1,
                color: Color(0xFFE5E5E5),
              ),
            ),
            Obx(() => SliverStickyHeader(
                  header: Container(
                    height: 50.0,
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      DateFormat('yyyy년 MM월 dd일')
                          .format(_viewModel.selectedDate),
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        // 스케줄의 startDate가 내일보다 이전이면 ClubDisAbleEventItem 반환
                        if (_viewModel.schedules[index].startDate.isBefore(
                            DateTime.now().add(const Duration(days: 1)))) {
                          return ClubDisAbleEventItem(
                            item: _viewModel.schedules[index],
                          );
                        } else {
                          return ClubAbleEventItem(
                            item: _viewModel.schedules[index],
                            onAgree: (int id) {
                              if (!_viewModel.updateSchedule(id, true)) {
                                Get.snackbar(
                                  "통신 오류",
                                  "동아리 일정 수락에 실패했습니다.",
                                  duration: const Duration(
                                      seconds: 1, milliseconds: 500),
                                  snackPosition: SnackPosition.TOP,
                                  margin: const EdgeInsets.only(
                                      top: 30, left: 20, right: 20),
                                );
                              }
                            },
                            onDisagree: (int id) {
                              if (!_viewModel.updateSchedule(id, false)) {
                                Get.snackbar(
                                  "통신 오류",
                                  "동아리 일정 수락에 실패했습니다.",
                                  duration: const Duration(
                                      seconds: 1, milliseconds: 500),
                                  snackPosition: SnackPosition.TOP,
                                  margin: const EdgeInsets.only(
                                      top: 30, left: 20, right: 20),
                                );
                              }
                            },
                          );
                        }
                      },
                      childCount: _viewModel.schedules.length,
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
