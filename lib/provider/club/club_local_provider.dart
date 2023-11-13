import 'package:get/get.dart';
import 'package:jjoin/model/club/club_home_info.dart';
import 'package:jjoin/model/club/club_notice.dart';
import 'package:jjoin/model/club/club_notice_detail.dart';
import 'package:jjoin/model/club/club_plan_detail.dart';

import '../../model/base/e_club_part.dart';
import '../../model/club/club_recommend.dart';
import '../../model/club/club_schedule.dart';

class ClubLocalProvider extends GetConnect {
  List<ClubHomeInfo> getHomeDummyMyClubInfos() {
    List<ClubHomeInfo> homeInfos = [
      ClubHomeInfo(
        id: 1,
        name: "컴퓨터공학과 학생회",
        introduction: "컴퓨터공학과 학생회입니다.",
        part: EClubPart.DEPARTMENT,
        memberCnt: 10,
        imageUuid:
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        leaderName: "김태욱",
        recentNotice: "컴퓨터공학과 학생회입니다.",
      ),
      ClubHomeInfo(
        id: 2,
        name: "GDSC",
        introduction: "모여서 가치를 만든다.",
        part: EClubPart.UNION,
        memberCnt: 37,
        imageUuid:
            "https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg",
        leaderName: "서희찬",
        recentNotice: "11월 10일 오픈 세미나",
      ),
      ClubHomeInfo(
        id: 3,
        name: "Farm System",
        introduction: "코딩 제사를 지낸다.",
        part: EClubPart.CENTRAL,
        memberCnt: 10,
        imageUuid:
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
        clubId: 1,
        clubName: "Farm System",
        title: "정기 회의",
        startDate: date,
        endDate: date.add(const Duration(days: 2)),
      ),
      ClubSchedule(
        id: 2,
        clubId: 1,
        clubName: "GDSC",
        title: "오픈 세미나",
        startDate: date,
        endDate: date.add(const Duration(hours: 1)),
      ),
      ClubSchedule(
        id: 3,
        clubId: 1,
        clubName: "멋쟁이사자처럼",
        title: "동아리 홍보전",
        startDate: date,
        endDate: date.add(const Duration(days: 1)),
      ),
      ClubSchedule(
        id: 4,
        clubId: 1,
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
              clubId: 1,
              clubName: "GDSC",
              title: "오픈 세미나",
              startDate: date,
              endDate: date.add(const Duration(hours: 1)),
            ),
            ClubSchedule(
              id: 3 + i,
              clubId: 1,
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
              clubId: 1,
              clubName: "Farm System",
              title: "정기 회의",
              startDate: date,
              endDate: date.add(const Duration(days: 2)),
            ),
            ClubSchedule(
              id: 3 + i,
              clubId: 1,
              clubName: "멋쟁이사자처럼",
              title: "동아리 홍보전",
              startDate: date,
              endDate: date.add(const Duration(days: 1)),
            ),
            ClubSchedule(
              id: 3 + i,
              clubId: 1,
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
              clubId: 1,
              clubName: "Farm System",
              title: "정기 회의",
              startDate: date,
              endDate: date.add(const Duration(days: 2)),
            ),
            ClubSchedule(
              id: 2 + i,
              clubId: 1,
              clubName: "GDSC",
              title: "오픈 세미나",
              startDate: date,
              endDate: date.add(const Duration(hours: 1)),
            ),
            ClubSchedule(
              id: 3 + i,
              clubId: 1,
              clubName: "멋쟁이사자처럼",
              title: "동아리 홍보전",
              startDate: date,
              endDate: date.add(const Duration(days: 1)),
            ),
            ClubSchedule(
              id: 3 + i,
              clubId: 1,
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
        clubId: 1,
        clubName: "Farm System",
        title: "정기 회의",
        startDate: date,
        endDate: date.add(const Duration(days: 2)),
      ),
      ClubSchedule(
        id: 2,
        clubId: 1,
        clubName: "GDSC",
        title: "오픈 세미나",
        startDate: date,
        endDate: date.add(const Duration(hours: 1)),
      ),
      ClubSchedule(
        id: 3,
        clubId: 1,
        clubName: "멋쟁이사자처럼",
        title: "동아리 홍보전",
        startDate: date,
        endDate: date.add(const Duration(days: 1)),
      ),
      ClubSchedule(
        id: 4,
        clubId: 1,
        clubName: "컴퓨터공학과 학생회",
        title: "회의해라 씨발 후배년들아",
        startDate: date,
        endDate: date.add(const Duration(hours: 3)),
      ),
    ];

    return clubSchedules;
  }

  List<ClubNotice> getClubDummyNotices(int clubId, int page, int size) {
    DateTime date = DateTime.now();

    List<ClubNotice> clubNotices = [
      ClubNotice(
        id: 1,
        title: "정기 훈련 연기",
        content: "이번주 일요일 날씨가 안좋아서 어쩌구 저쩌구 .............................",
        updateDate: date,
      ),
      ClubNotice(
        id: 2,
        title: "비정기 훈련 연기",
        content: "이번주 일요일 날씨가 안좋아서 어쩌구 저쩌구 .............................",
        updateDate: date,
      ),
      ClubNotice(
        id: 3,
        title: "FC 토토배 출전멤버",
        content: "이번주 토토배 출전 멤버 뽑겠습니다 어쩌구 저쩌구 .............................",
        updateDate: date.subtract(const Duration(days: 1)),
      ),
      ClubNotice(
        id: 4,
        title: "FC 토토배 대기멤버",
        content: "이번주 토토배 출전 멤버 뽑겠습니다 어쩌구 저쩌구 .............................",
        updateDate: date.subtract(const Duration(days: 1)),
      )
    ];

    // date 기준 10일 전까지 더미 데이터 생성
    for (int i = 1; i < 10; i++) {
      clubNotices.add(
        ClubNotice(
          id: 1 + i,
          title: "정기 훈련 연기",
          content: "이번주 일요일 날씨가 안좋아서 어쩌구 저쩌구 .............................",
          updateDate: date.subtract(Duration(days: i)),
        ),
      );
      clubNotices.add(
        ClubNotice(
          id: 2 + i,
          title: "비정기 훈련 연기",
          content: "이번주 일요일 날씨가 안좋아서 어쩌구 저쩌구 .............................",
          updateDate: date.subtract(Duration(days: i)),
        ),
      );
      clubNotices.add(
        ClubNotice(
          id: 3 + i,
          title: "FC 토토배 출전멤버",
          content: "이번주 토토배 출전 멤버 뽑겠습니다 어쩌구 저쩌구 .............................",
          updateDate: date.subtract(Duration(days: i)),
        ),
      );
      clubNotices.add(
        ClubNotice(
          id: 4 + i,
          title: "FC 토토배 대기멤버",
          content: "이번주 토토배 출전 멤버 뽑겠습니다 어쩌구 저쩌구 .............................",
          updateDate: date.subtract(Duration(days: i)),
        ),
      );
    }

    return clubNotices;
  }

  List<ClubSchedule> getClubDummySchedules(int clubId, int page, int size) {
    DateTime date = DateTime.now();

    List<ClubSchedule> clubSchedules = [
      ClubSchedule(
        id: 1,
        title: "정기 회의",
        startDate: date,
        endDate: date.add(const Duration(days: 2)),
      ),
      ClubSchedule(
        id: 2,
        title: "오픈 세미나",
        startDate: date,
        endDate: date.add(const Duration(hours: 1)),
      ),
      ClubSchedule(
        id: 3,
        title: "동아리 홍보전",
        startDate: date,
        endDate: date.add(const Duration(days: 1)),
      ),
      ClubSchedule(
        id: 3,
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
          title: "동아리 홍보전",
          startDate: date.subtract(Duration(days: i)),
          endDate:
              date.subtract(Duration(days: i)).add(const Duration(days: 1)),
        ),
      );
    }

    return clubSchedules.sublist(page * size, (page + 1) * size);
  }

  ClubNoticeDetail getClubDummyNoticeDetail(int id) {
    DateTime date = DateTime.now();

    return ClubNoticeDetail(
      id: 1,
      title: "정기 축구 연습",
      content: "안녕하세요.\n"
          "FC 세미콜론 주장, 이선호입니다.\n"
          "이번주 정기 축구 연습은 10.1(월)입니다.\n"
          "\n"
          "오랜만에 다같이 축구한번하고 뒷풀이 합시다.\n"
          "늦지 않게 오시길 바랍니다."
          "\n\n[위치] 중구 서애로 5길 21 - 선호빌딩 123호\n"
          "\n"
          "[뒷풀이] 남산골 생고기 - 중구 서애로 5길 21",
      updatedDate: date,
      createdDate: date.subtract(const Duration(days: 1)),
    );
  }

  ClubPlanDetail getClubDummyPlanDetail(int clubId, int scheduleId) {
    DateTime date = DateTime.now();

    return ClubPlanDetail(
      id: scheduleId,
      title: "정기 축구 연습",
      content: "안녕하세요.\n"
          "FC 세미콜론 주장, 이선호입니다.\n"
          "이번주 정기 축구 연습은 10.1(월)입니다.\n"
          "\n"
          "오랜만에 다같이 축구한번하고 뒷풀이 합시다.\n"
          "늦지 않게 오시길 바랍니다."
          "\n\n[위치] 중구 서애로 5길 21 - 선호빌딩 123호\n"
          "\n"
          "[뒷풀이] 남산골 생고기 - 중구 서애로 5길 21",
      startDate: date.add(const Duration(days: 5)),
      endDate: date.add(const Duration(days: 5, hours: 2)),
      updatedDate: date,
      createdDate: date.subtract(const Duration(days: 1)),
      isAgree: true,
      numberOfAgree: 10,
      numberOfDisagree: 2,
    );
  }
}
