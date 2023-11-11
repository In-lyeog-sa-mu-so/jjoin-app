import 'package:flutter/material.dart';
import 'package:jjoin/widget/base/default_appbar.dart';

import '../model/club/club_schedule.dart';
import '../widget/calendar/schedule_calendar.dart';
import '../widget/club/club_event_item_widget.dart';

class CalendarScreen extends StatelessWidget {
  const CalendarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: DefaultAppBar(
          title: "일정",
        ),
      ),
      body: Center(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ScheduleCalendar(),
            ),
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                height: 1,
                color: Color(0xFFE5E5E5),
              ),
            ),
            const SliverToBoxAdapter(
                child: Padding(
              // 왼쪽만 패딩
              padding: EdgeInsets.only(left: 25, top: 5, bottom: 5),
              child: Text(
                "일정",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ClubEventItem(
                      item: ClubEvent(
                    id: 1,
                    title: "2023년 2학기 동아리 홍보전",
                    date: "2023-10-10 18:30",
                  ));
                },
                childCount: 5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
