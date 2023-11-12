import 'package:jjoin/model/club/club_recommend.dart';
import 'package:jjoin/model/club/club_schedule.dart';

import '../../model/club/club_home_info.dart';
import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_remote_provider.dart';
import '../../utilities/date_time_util.dart';

class ClubRepository {
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
  List<ClubHomeInfo> getHomeMyClubInfos() {
    return clubLocalProvider.getHomeDummyMyClubInfos();
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
  List<ClubSchedule> getClubSchedules(DateTime date) {
    return clubLocalProvider.getClubDummySchedules(date);
  }
}
