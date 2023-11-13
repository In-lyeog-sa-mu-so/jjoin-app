import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:jjoin/model/club/club_notice.dart';
import 'package:jjoin/model/club/club_notice_detail.dart';
import 'package:jjoin/model/club/club_plan_detail.dart';
import 'package:jjoin/model/club/club_recommend.dart';
import 'package:jjoin/model/club/club_schedule.dart';

import '../../model/club/club_home_info.dart';
import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_remote_provider.dart';
import '../../utilities/date_time_util.dart';

class ClubRepository {
  static final String _imageUrl = dotenv.env['JJOIN_IMAGE_SERVER_URL']!;
  final ClubRemoteProvider clubRemoteProvider;
  final ClubLocalProvider clubLocalProvider;

  ClubRepository({
    required this.clubRemoteProvider,
    required this.clubLocalProvider,
  }) : assert(clubRemoteProvider != null || clubLocalProvider != null);

  /* Common */
  bool updateSchedule(int id, bool isAgree) {
    return true;
  }

  /* Home */
  Future<List<ClubHomeInfo>> readJoinClubs() async {
    Map<String, dynamic> data = await clubRemoteProvider.getJoinClubs();

    return data["data"]
        .map<ClubHomeInfo>((json) => ClubHomeInfo.fromJson(
              json: json,
              imageUrl: _imageUrl,
            ))
        .toList();
  }

  List<ClubSchedule> getHomeMyClubSchedules() {
    return clubLocalProvider.getHomeDummyMyClubSchedules();
  }

  List<ClubRecommend> getHomeRecommendClubs() {
    return clubLocalProvider.getHomeDummyRecommendClubs();
  }

  /* Calendar */
  Map<String, List<ClubSchedule>> getCalendarSchedules(DateTime focusedDate) {
    DateTime firstDayOfMonth = DateTimeUtil.getFirstDayOfCalendar(focusedDate);
    DateTime lastDayOfMonth = DateTimeUtil.getLastDayOfCalendar(focusedDate);
    var response = clubLocalProvider.getCalendarDummySchedules(
        firstDayOfMonth, lastDayOfMonth);

    return response;
  }

  List<ClubSchedule> getCalendarScheduleForDate(DateTime date) {
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
