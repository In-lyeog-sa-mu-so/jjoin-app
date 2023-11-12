import 'package:jjoin/model/club/club_schedule.dart';

import '../../provider/club/club_local_provider.dart';
import '../../provider/club/club_remote_provider.dart';

class ClubRepository {
  final ClubRemoteProvider clubRemoteProvider;
  final ClubLocalProvider clubLocalProvider;

  ClubRepository({
    required this.clubRemoteProvider,
    required this.clubLocalProvider,
  }) : assert(clubRemoteProvider != null || clubLocalProvider != null);

  Map<String, dynamic> getCalendarSchedules(
      DateTime startDate, DateTime endDate) {
    return clubLocalProvider.getDummyCalendarSchedules(startDate, endDate);
  }

  List<ClubSchedule> getClubSchedule(DateTime date) {
    return clubLocalProvider.getClubDummyClubSchedule(date);
  }

  List<ClubSchedule> getHomeClubSchedule() {
    return clubLocalProvider.getHomeDummyClubSchedule();
  }
}
