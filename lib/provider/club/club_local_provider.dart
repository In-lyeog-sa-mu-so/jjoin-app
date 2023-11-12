import 'package:get/get.dart';

import '../../model/club/calendar_schedule.dart';
import '../../model/club/club_schedule.dart';

class ClubLocalProvider extends GetConnect {
  Map<String, CalendarSchedule> getDummyCalendarSchedules(
      DateTime startDate, DateTime endDate) {
    Map<String, CalendarSchedule> calendarSchedules = {};

    for (int i = 0; i < endDate.difference(startDate).inDays; i++) {
      DateTime date = startDate.add(Duration(days: i));
      switch (i % 4) {
        case 0:
          calendarSchedules[date.toString().substring(0, 10)] =
              CalendarSchedule(
            date: date,
            todos: [],
          );
          break;
        case 1:
          calendarSchedules[date.toString().substring(0, 10)] =
              CalendarSchedule(
            date: date,
            todos: [
              ClubSchedule(
                id: 2 + i,
                clubName: "GDSC",
                title: "오픈 세미나",
                startDate: date,
                endDate: date.add(const Duration(hours: 1)),
              ),
              ClubSchedule(
                id: 3 + i,
                clubName: "컴퓨터공학과 학생회",
                title: "회의해라 씨발 후배년들아",
                startDate: date,
                endDate: date.add(const Duration(hours: 3)),
              ),
            ],
          );
          break;
        case 2:
          calendarSchedules[date.toString().substring(0, 10)] =
              CalendarSchedule(
            date: date,
            todos: [
              ClubSchedule(
                id: 1 + i,
                clubName: "Farm System",
                title: "정기 회의",
                startDate: date,
                endDate: date.add(const Duration(days: 2)),
              ),
              ClubSchedule(
                id: 3 + i,
                clubName: "멋쟁이사자처럼",
                title: "동아리 홍보전",
                startDate: date,
                endDate: date.add(const Duration(days: 1)),
              ),
              ClubSchedule(
                id: 3 + i,
                clubName: "컴퓨터공학과 학생회",
                title: "회의해라 씨발 후배년들아",
                startDate: date,
                endDate: date.add(const Duration(hours: 3)),
              ),
            ],
          );
          break;
        case 3:
          calendarSchedules[date.toString().substring(0, 10)] =
              CalendarSchedule(
            date: date,
            todos: [
              ClubSchedule(
                id: 1 + i,
                clubName: "Farm System",
                title: "정기 회의",
                startDate: date,
                endDate: date.add(const Duration(days: 2)),
              ),
              ClubSchedule(
                id: 2 + i,
                clubName: "GDSC",
                title: "오픈 세미나",
                startDate: date,
                endDate: date.add(const Duration(hours: 1)),
              ),
              ClubSchedule(
                id: 3 + i,
                clubName: "멋쟁이사자처럼",
                title: "동아리 홍보전",
                startDate: date,
                endDate: date.add(const Duration(days: 1)),
              ),
              ClubSchedule(
                id: 3 + i,
                clubName: "컴퓨터공학과 학생회",
                title: "회의해라 씨발 후배년들아",
                startDate: date,
                endDate: date.add(const Duration(hours: 3)),
              ),
            ],
          );
          break;
      }
    }

    return calendarSchedules;
  }

  List<ClubSchedule> getHomeDummyClubSchedule() {
    DateTime date = DateTime.now().add(const Duration(days: 3));

    List<ClubSchedule> clubSchedules = [
      ClubSchedule(
        id: 1,
        clubName: "Farm System",
        title: "정기 회의",
        startDate: date,
        endDate: date.add(const Duration(days: 2)),
      ),
      ClubSchedule(
        id: 2,
        clubName: "GDSC",
        title: "오픈 세미나",
        startDate: date,
        endDate: date.add(const Duration(hours: 1)),
      ),
      ClubSchedule(
        id: 3,
        clubName: "멋쟁이사자처럼",
        title: "동아리 홍보전",
        startDate: date,
        endDate: date.add(const Duration(days: 1)),
      ),
      ClubSchedule(
        id: 3,
        clubName: "컴퓨터공학과 학생회",
        title: "회의해라 씨발 후배년들아",
        startDate: date,
        endDate: date.add(const Duration(hours: 3)),
      ),
    ];

    return clubSchedules;
  }

  List<ClubSchedule> getClubDummyClubSchedule(DateTime date) {
    // date 기준 10일 전까지 더미 데이터 생성
    List<ClubSchedule> clubSchedules = [
      ClubSchedule(
        id: 1,
        clubName: "Farm System",
        title: "정기 회의",
        startDate: date,
        endDate: date.add(const Duration(days: 2)),
      ),
      ClubSchedule(
        id: 2,
        clubName: "GDSC",
        title: "오픈 세미나",
        startDate: date,
        endDate: date.add(const Duration(hours: 1)),
      ),
      ClubSchedule(
        id: 3,
        clubName: "멋쟁이사자처럼",
        title: "동아리 홍보전",
        startDate: date,
        endDate: date.add(const Duration(days: 1)),
      ),
      ClubSchedule(
        id: 3,
        clubName: "컴퓨터공학과 학생회",
        title: "회의해라 씨발 후배년들아",
        startDate: date,
        endDate: date.add(const Duration(hours: 3)),
      ),
    ];

    for (int i = 0; i < 10; i++) {
      clubSchedules.add(
        ClubSchedule(
          id: 1 + i,
          clubName: "Farm System",
          title: "정기 회의",
          startDate: date.subtract(Duration(days: i)),
          endDate:
              date.subtract(Duration(days: i)).add(const Duration(days: 2)),
          isParticipate: true,
        ),
      );
      clubSchedules.add(
        ClubSchedule(
          id: 2 + i,
          clubName: "GDSC",
          title: "오픈 세미나",
          startDate: date.subtract(Duration(days: i)),
          endDate:
              date.subtract(Duration(days: i)).add(const Duration(hours: 1)),
          isParticipate: false,
        ),
      );
      clubSchedules.add(
        ClubSchedule(
          id: 3 + i,
          clubName: "멋쟁이사자처럼",
          title: "동아리 홍보전",
          startDate: date.subtract(Duration(days: i)),
          endDate:
              date.subtract(Duration(days: i)).add(const Duration(days: 1)),
        ),
      );
    }

    return clubSchedules;
  }
}
