import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:jjoin/model/club/club_notice.dart';
import 'package:jjoin/model/club/club_notice_detail.dart';
import 'package:jjoin/model/club/club_plan_detail.dart';
import 'package:jjoin/model/club/club_recommend.dart';
import 'package:jjoin/model/club/club_schedule.dart';

import '../../model/club/club_home_info.dart';
import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_provider.dart';
import '../../utilities/date_time_util.dart';

class ClubRepository {
  static final String _imageUrl = dotenv.env['JJOIN_IMAGE_SERVER_URL']!;
  final ClubProvider clubProvider;
  final ClubLocalProvider clubLocalProvider;

  ClubRepository({
    required this.clubProvider,
    required this.clubLocalProvider,
  });

  /* Common */
  Future<bool> updateSchedule(int id, bool isAgree) async {
    return await clubProvider.patchSchedule(id);
  }

  /* Home */
  Future<List<ClubHomeInfo>> readUserJoinClubs() async {
    Map<String, dynamic> data = await clubProvider.getJoinClubs();

    return data["data"]
        .map<ClubHomeInfo>(
            (json) => ClubHomeInfo.fromJson(json: json, imageUrl: _imageUrl))
        .toList();
  }

  Future<List<ClubSchedule>> readUserSchedules() async {
    Map<String, dynamic> data = await clubProvider.getUserSchedules();

    return data["data"]
        .map<ClubSchedule>((json) => ClubSchedule.fromJson(json: json))
        .toList();
  }

  Future<List<ClubRecommend>> readUserRecommendClubs() async {
    Map<String, dynamic> data = await clubProvider.getUserRecommendClubs();

    return data["data"]
        .map<ClubRecommend>(
            (json) => ClubRecommend.fromJson(json: json, imageUrl: _imageUrl))
        .toList();
  }

  /* Calendar */
  Future<Map<String, List<String>>> getCalendarSchedules(
      DateTime focusedDate) async {
    DateTime firstDayOfMonth = DateTimeUtil.getFirstDayOfCalendar(focusedDate);
    DateTime lastDayOfMonth = DateTimeUtil.getLastDayOfCalendar(focusedDate);

    Map<String, dynamic> data = await clubProvider.getUserCalendar(
      firstDayOfMonth,
      lastDayOfMonth,
    );

    Map<String, List<String>> result = {};

    // for (int i = 0; i < data["data"].length; i++) {
    //   String date = DateFormat("yyyy-MM-dd")
    //       .format(DateTime.parse(data["data"][i]["date"]));
    //   List<String> schedules = data["data"][i]["scheduleDayDtos"]
    //       .map<String>((json) => json["name"])
    //       .toList();
    //
    //   result[date] = schedules;
    // }

    return result;
  }

  List<ClubSchedule> getCalendarScheduleForDate(DateTime date) {
    print(date);
    return clubLocalProvider.getCalendarDummyScheduleForDate(date);
  }

  /* Club */
  List<ClubNotice> getClubNotices(int clubId, int page, int size) {
    return clubLocalProvider.getClubDummyNotices(clubId, page, size);
  }

  List<ClubSchedule> getClubSchedules(int clubId, int page, int size) {
    return clubLocalProvider.getClubDummySchedules(clubId, page, size);
  }

  /* Club Notice Detail */
  ClubNoticeDetail getClubNoticeDetail(int id) {
    return clubLocalProvider.getClubDummyNoticeDetail(id);
  }

  ClubPlanDetail getPlanDetail(int clubId, int scheduleId) {
    return clubLocalProvider.getClubDummyPlanDetail(clubId, scheduleId);
  }
}
