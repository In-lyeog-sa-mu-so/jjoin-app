import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:intl/intl.dart';
import 'package:jjoin/model/club/club_notice.dart';
import 'package:jjoin/model/club/club_notice_detail.dart';
import 'package:jjoin/model/club/club_plan_detail.dart';
import 'package:jjoin/model/club/club_recommend.dart';
import 'package:jjoin/model/club/club_schedule.dart';

import '../../model/base/page_info.dart';
import '../../model/club/club_home_info.dart';
import '../../model/club/club_model.dart';
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
    return await clubProvider.patchSchedule(id, isAgree);
  }

  /* Home */
  Future<List<ClubHomeInfo>> readUserJoinClubs() async {
    Map<String, dynamic> data = await clubProvider.getJoinClubs();

    var result = data["data"]
        .map<ClubHomeInfo>(
            (json) => ClubHomeInfo.fromJson(json: json, imageUrl: _imageUrl))
        .toList();

    if (result.length == 0) {
      result.add(ClubHomeInfo.empty());
    }

    return result;
  }

  Future<List<ClubSchedule>> readUserSchedules() async {
    Map<String, dynamic> data = await clubProvider.getUserSchedules();

    var result = data["data"]
        .map<ClubSchedule>((json) => ClubSchedule.fromJson(json: json))
        .toList();

    if (result.length == 0) {
      result.add(ClubSchedule.empty());
    }

    return result;
  }

  Future<List<ClubRecommend>> readUserRecommendClubs() async {
    Map<String, dynamic> data = await clubProvider.getUserRecommendClubs();

    var result = data["data"]
        .map<ClubRecommend>(
            (json) => ClubRecommend.fromJson(json: json, imageUrl: _imageUrl))
        .toList();

    if (result.length == 0) {
      result.add(ClubRecommend.empty());
    }

    return result;
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

    for (int i = 0; i < data["data"].length; i++) {
      String date = DateFormat('yyyy-MM-dd')
          .format(DateTime.parse(data["data"][i]["date"]).toLocal());

      List<String> names = [];
      for (int j = 0; j < data["data"][i]["scheduleDayDtos"].length; j++) {
        names.add(data["data"][i]["scheduleDayDtos"][j]["name"]);
      }
      result[date] = names;
    }

    return result;
  }

  Future<List<ClubSchedule>> getCalendarScheduleForDate(DateTime date) async {
    Map<String, dynamic> data = await clubProvider.getUserSchedulesByDate(date);

    var result = data["data"]
        .map<ClubSchedule>((json) => ClubSchedule.fromJson(json: json))
        .toList();

    if (result.length == 0) {
      result.add(ClubSchedule.empty());
    }

    return result;
  }

  /* Club */
  Future<Map<String, dynamic>> readClubNotices(
    int clubId,
    int page,
    int size,
  ) async {
    Map<String, dynamic> data =
        await clubProvider.getClubNotices(clubId, page, size);

    var dataList = data["data"]
        .map<ClubNotice>((json) => ClubNotice.fromJson(json: json))
        .toList();

    if (dataList.length == 0) {
      dataList.add(ClubNotice.empty());
    }

    PageInfo pageInfo;
    if (data["pageInfo"] != null) {
      pageInfo = PageInfo.fromJson(json: data["pageInfo"]);
    } else {
      pageInfo = PageInfo.empty();
    }

    return {
      "dataList": dataList,
      "pageInfo": pageInfo,
    };
  }

  Future<Map<String, dynamic>> readClubSchedules(
    int clubId,
    int page,
    int size,
  ) async {
    print("$clubId, $page, $size");
    Map<String, dynamic> data =
        await clubProvider.getClubPlans(clubId, page, size);

    var dataList = data["data"]
        .map<ClubSchedule>((json) => ClubSchedule.fromJson(json: json))
        .toList();

    if (dataList.length == 0) {
      dataList.add(ClubSchedule.empty());
    }

    PageInfo pageInfo;
    if (data["pageInfo"] != null) {
      pageInfo = PageInfo.fromJson(json: data["pageInfo"]);
    } else {
      pageInfo = PageInfo.empty();
    }

    return {
      "dataList": dataList,
      "pageInfo": pageInfo,
    };
  }

  /* Club Notice Detail */
  ClubNoticeDetail getClubNoticeDetail(int id) {
    return clubLocalProvider.getClubDummyNoticeDetail(id);
  }

  ClubPlanDetail getPlanDetail(int clubId, int scheduleId) {
    return clubLocalProvider.getClubDummyPlanDetail(clubId, scheduleId);
  }

  Future<ClubModel> readClubInfo(int clubId) async {
    Map<String, dynamic> data = await clubProvider.getClubInfo(clubId);

    if (data["id"] == null) {
      return ClubModel.empty();
    }

    return ClubModel.fromJson(json: data, imageUrl: _imageUrl);
  }
}
