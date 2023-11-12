import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:jjoin/widget/base/default_appbar.dart';

import '../../model/club/club_schedule.dart';
import '../../widget/calendar/schedule_calendar.dart';
import '../../widget/club/club_event_item_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

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
            // SliverToBoxAdapter(
            //   child: ScheduleCalendar(),
            // ),
            // SliverToBoxAdapter(
            //   child: Container(
            //     margin: EdgeInsets.only(top: 10),
            //     width: double.infinity,
            //     height: 1,
            //     color: Color(0xFFE5E5E5),
            //   ),
            // ),
            // SliverStickyHeader(
            //   header: Container(
            //     height: 50.0,
            //     color: Colors.white,
            //     padding: EdgeInsets.symmetric(horizontal: 16.0),
            //     alignment: Alignment.centerLeft,
            //     child: Text(
            //       "2023년 11월 12일",
            //       style: TextStyle(
            //         fontSize: 21,
            //         fontWeight: FontWeight.bold,
            //       ),
            //     ),
            //   ),
            //   sliver: SliverList(
            //     delegate: SliverChildBuilderDelegate(
            //       (context, index) {
            //         return ClubEventItem(
            //             item: ClubSchedule(
            //           id: 1,
            //           title: "2023년 2학기 동아리 홍보전",
            //           date: "2023-10-10 18:30",
            //         ));
            //       },
            //       childCount: 7,
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
