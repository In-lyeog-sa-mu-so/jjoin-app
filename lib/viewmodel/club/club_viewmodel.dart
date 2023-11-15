import 'package:get/get.dart';

import '../../model/base/page_info.dart';
import '../../model/base/page_list_model.dart';
import '../../model/club/club_model.dart';
import '../../model/club/club_notice.dart';
import '../../model/club/club_schedule.dart';
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

  /* Club Notices */
  late final Rx<PageListModel<ClubNotice>> _noticePage;
  late final RxBool _isLoadingNotices;
  List<ClubNotice> get notices => _noticePage.value.dataList;
  PageInfo get noticePageInfo => _noticePage.value.pageInfo;
  bool get isLoadingNotices => _isLoadingNotices.value;

  /* Club Schedules */
  late final Rx<PageListModel<ClubSchedule>> _schedulePage;
  late final RxBool _isLoadingSchedules;
  List<ClubSchedule> get schedules => _schedulePage.value.dataList;
  PageInfo get schedulePageInfo => _schedulePage.value.pageInfo;
  bool get isLoadingSchedules => _isLoadingSchedules.value;

  @override
  void onInit() {
    super.onInit();

    _isLoadingClubInfo = false.obs;
    _isLoadingNotices = false.obs;
    _isLoadingSchedules = false.obs;

    initClubInfo();
    initNotices();
    initSchedules();
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

  void initSchedules() {
    _isLoadingSchedules.value = true;
    clubRepository
        .readClubSchedules(clubId, 0, 5)
        .then((value) => {
              _schedulePage = PageListModel<ClubSchedule>(
                dataList: value["dataList"],
                pageInfo: value["pageInfo"],
              ).obs,
              print(_schedulePage),
            })
        .then((value) => _isLoadingSchedules.value = false);
  }

  void initNotices() {
    _isLoadingNotices.value = true;
    clubRepository
        .readClubNotices(clubId, 0, 5)
        .then(
          (value) => _noticePage = PageListModel<ClubNotice>(
            dataList: value["dataList"],
            pageInfo: value["pageInfo"],
          ).obs,
        )
        .then((value) => _isLoadingNotices.value = false);
    _isLoadingNotices.value = false;
  }
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
