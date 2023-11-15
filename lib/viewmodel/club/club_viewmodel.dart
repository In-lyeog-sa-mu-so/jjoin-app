import 'package:get/get.dart';

import '../../model/club/club_model.dart';
import '../../repository/club/club_repository.dart';

class ClubViewModel extends GetxController {
  final int clubId;
  final ClubRepository clubRepository;

  ClubViewModel({
    required this.clubId,
    required this.clubRepository,
  });

  /* Club Information */
  late final ClubModel _clubModel;
  late final RxBool _isLoadingClubInfo;
  ClubModel get clubModel => _clubModel;
  bool get isLoadingClubInfo => _isLoadingClubInfo.value;

  // /* Club Notices */
  // late final RxList<ClubNotice> _notices;
  // late final RxBool _isLoadingNotices;
  // late PageInfo _noticePageInfo;
  // List<ClubNotice> get notices => _notices;
  // bool get isLoadingNotices => _isLoadingNotices.value;
  //
  // /* Club Schedules */
  // late final RxList<ClubSchedule> _schedules;
  // late final RxBool _isLoadingSchedules;
  // late PageInfo _schedulePageInfo;
  // List<ClubSchedule> get schedules => _schedules;
  // bool get isLoadingSchedules => _isLoadingSchedules.value;

  @override
  void onInit() {
    super.onInit();

    _isLoadingClubInfo = false.obs;
    initClubInfo();
    // _isLoadingNotices = false.obs;
    // _isLoadingSchedules = false.obs;
    //
    // fetchSchedules();
    // fetchNotices();
  }

  /* init */
  void initClubInfo() {
    _isLoadingClubInfo.value = true;
    clubRepository
        .readClubInfo(clubId)
        .then((value) => {
              _clubModel = value,
              print(_clubModel),
            })
        .then((value) => _isLoadingClubInfo.value = false);
  }

  // void initSchedules() {
  //   _isLoadingSchedules.value = true;
  //   _schedules.value = clubRepository.getClubSchedules(
  //       clubId, _schedulePageInfo.currentPage, _schedulePageInfo.pageSize);
  //   _isLoadingSchedules.value = false;
  // }
  //
  // void initNotices() {
  //   _isLoadingNotices.value = true;
  //   _notices.value = clubRepository.getClubNotices(
  //       clubId, _noticePageInfo.currentPage, _noticePageInfo.pageSize);
  //   _isLoadingNotices.value = false;
  // }
  //
  // /* fetch */
  // void fetchSchedules() {
  //   _isLoadingSchedules.value = true;
  //   _schedules.value = clubRepository.getClubSchedules(
  //       clubId, _schedulePageInfo.currentPage, _schedulePageInfo.pageSize);
  //   _isLoadingSchedules.value = false;
  // }
  //
  // void fetchNotices() {
  //   _isLoadingNotices.value = true;
  //   _notices.value = clubRepository.getClubNotices(
  //       clubId, _noticePageInfo.currentPage, _noticePageInfo.pageSize);
  //   _isLoadingNotices.value = false;
  // }
  //
  // bool updateSchedule(int id, bool isAgree) {
  //   bool isSuccess = false;
  //   clubRepository.updateSchedule(id, isAgree).then((value) => {
  //         if (value)
  //           {
  //             _schedules.removeWhere((element) => element.id == id),
  //             isSuccess = true
  //           }
  //         else
  //           {
  //             isSuccess = false,
  //           }
  //       });
  //
  //   return isSuccess;
  // }
}
