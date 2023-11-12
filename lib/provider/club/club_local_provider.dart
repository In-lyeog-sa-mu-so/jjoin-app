import 'package:get/get.dart';
import 'package:jjoin/model/club/club_home_info.dart';

import '../../model/base/e_club_part.dart';
import '../../model/club/club_recommend.dart';
import '../../model/club/club_schedule.dart';

class ClubLocalProvider extends GetConnect {
  List<ClubHomeInfo> getHomeDummyMyClubInfos() {
    List<ClubHomeInfo> homeInfos = [
      ClubHomeInfo(
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
      ClubHomeInfo(
        id: 1,
        name: "GDSC",
        description: "모여서 가치를 만든다.",
        part: EClubPart.UNION,
        memberCnt: 37,
        imageURL:
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        leaderName: "서희찬",
        recentNotice: "11월 10일 오픈 세미나",
      ),
      ClubHomeInfo(
        id: 1,
        name: "Farm System",
        description: "코딩 제사를 지낸다.",
        part: EClubPart.DEPARTMENT,
        memberCnt: 10,
        imageURL:
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        leaderName: "서희찬",
        recentNotice: "11월 1일 정기 보고",
      )
    ];

    return homeInfos;
  }

  List<ClubSchedule> getHomeDummyMyClubSchedules() {
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
        id: 4,
        clubName: "컴퓨터공학과 학생회",
        title: "회의해라 씨발 후배년들아",
        startDate: date,
        endDate: date.add(const Duration(hours: 3)),
      ),
    ];

    return clubSchedules;
  }

  List<ClubRecommend> getHomeDummyRecommendClubs() {
    List<ClubRecommend> clubRecommends = [
      ClubRecommend(
        id: 1,
        name: "GDSC DGU",
        description: "모여서 가치를 만든다.",
        part: EClubPart.DEPARTMENT,
        memberCnt: 37,
        imageURL:
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        tags: ["친목", "학술", "공유"],
      ),
      ClubRecommend(
        id: 1,
        name: "컴퓨터공학과 학생회",
        description: "컴퓨터공학과 학생회입니다.",
        part: EClubPart.DEPARTMENT,
        memberCnt: 30,
        imageURL:
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        tags: ["친목", "학술"],
      ),
      ClubRecommend(
        id: 1,
        name: "Farm System",
        description: "코딩 제사를 지낸다.",
        part: EClubPart.DEPARTMENT,
        memberCnt: 20,
        imageURL:
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        tags: ["친목", "학술", "코딩"],
      )
    ];

    return clubRecommends;
  }

  Map<String, List<ClubSchedule>> getCalendarDummySchedules(
      DateTime startDate, DateTime endDate) {
    Map<String, List<ClubSchedule>> calendarSchedules = {};

    for (int i = 0; i < endDate.difference(startDate).inDays; i++) {
      DateTime date = startDate.add(Duration(days: i));
      switch (i % 4) {
        case 0:
          calendarSchedules[date.toString().substring(0, 10)] = [];
          break;
        case 1:
          calendarSchedules[date.toString().substring(0, 10)] = [
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
          ];
          break;
        case 2:
          calendarSchedules[date.toString().substring(0, 10)] = [
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
          ];
          break;
        case 3:
          calendarSchedules[date.toString().substring(0, 10)] = [
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
          ];
          break;
      }
    }

    return calendarSchedules;
  }

  List<ClubSchedule> getCalendarDummyScheduleForDate(DateTime date) {
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

  List<ClubSchedule> getClubDummySchedules(DateTime date) {
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

    // date 기준 10일 전까지 더미 데이터 생성
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
