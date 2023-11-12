import 'package:get/get.dart';
import 'package:jjoin/model/club/club_notice.dart';

import '../../model/club/club_schedule.dart';
import '../../repository/club/club_repository.dart';

class ClubViewModel extends GetxController {
  final ClubRepository clubRepository;

  ClubViewModel({required this.clubRepository})
      : assert(clubRepository != null);

  /* Club Notices */
  final RxList<ClubNotice> _notices = RxList();
  final RxBool _isLoadingNotices = false.obs;
  List<ClubNotice> get notices => _notices;
  bool get isLoadingNotices => _isLoadingNotices.value;
  int noticePage = 0;
  int noticeSize = 5;

  /* Club Schedules */
  final RxList<ClubSchedule> _schedules = RxList();
  final RxBool _isLoadingSchedules = false.obs;
  List<ClubSchedule> get schedules => _schedules;
  bool get isLoadingSchedules => _isLoadingSchedules.value;
  int schedulePage = 0;
  int scheduleSize = 5;

  @override
  void onInit() {
    super.onInit();

    fetchSchedules();
    fetchNotices();
  }

  void fetchSchedules() {
    _isLoadingSchedules.value = true;
    _schedules.value =
        clubRepository.getClubSchedules(schedulePage, scheduleSize);
    _isLoadingSchedules.value = false;
  }

  void fetchNotices() {
    _isLoadingNotices.value = true;
    _notices.value = clubRepository.getClubNotices(noticePage, noticeSize);
    _isLoadingNotices.value = false;
  }

  bool updateSchedule(int id, bool isAgree) {
    return clubRepository.updateSchedule(id, isAgree);
  }
}
