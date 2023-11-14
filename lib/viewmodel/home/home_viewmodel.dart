import 'package:get/get.dart';
import 'package:jjoin/model/club/club_recommend.dart';
import 'package:jjoin/repository/club/club_repository.dart';
import 'package:jjoin/viewmodel/calendar/calendar_viewmodel.dart';

import '../../model/club/club_home_info.dart';
import '../../model/club/club_schedule.dart';

class HomeViewModel extends GetxController {
  final ClubRepository clubRepository;

  HomeViewModel({required this.clubRepository});

  /* Club Home Info */
  late final RxList<ClubHomeInfo> _userJoinClubs;
  late final RxBool _isLoadingUserJoinClubs;
  List<ClubHomeInfo> get userJoinClubs => _userJoinClubs;
  bool get isLoadingUserJoinClubs => _isLoadingUserJoinClubs.value;

  /* Club Schedules */
  late final RxList<ClubSchedule> _userSchedules;
  late final RxBool _isLoadingUserSchedules;
  List<ClubSchedule> get userSchedules => _userSchedules;
  bool get isLoadingUserSchedules => _isLoadingUserSchedules.value;

  /* Club Recommend */
  late final RxList<ClubRecommend> _userRecommendClubs;
  late final RxBool _isLoadingRecommendClubs;
  List<ClubRecommend> get userRecommendClubs => _userRecommendClubs;
  bool get isLoadingRecommendClubsForUser => _isLoadingRecommendClubs.value;

  @override
  void onInit() {
    super.onInit();
    _isLoadingUserJoinClubs = false.obs;
    _isLoadingUserSchedules = false.obs;
    _isLoadingRecommendClubs = false.obs;

    initUserJoinClubs();
    initUserSchedules();
    initRecommendClubs();
  }

  /* Init Date */
  void initUserJoinClubs() {
    _isLoadingUserJoinClubs.value = true;
    clubRepository
        .readUserJoinClubs()
        .then((value) => _userJoinClubs = value.obs)
        .then((_) => _isLoadingUserJoinClubs.value = false);
  }

  void initUserSchedules() {
    _isLoadingUserSchedules.value = true;
    clubRepository
        .readUserSchedules()
        .then((value) => _userSchedules = value.obs)
        .then((value) => _isLoadingUserSchedules.value = false);
  }

  void initRecommendClubs() {
    _isLoadingRecommendClubs.value = true;
    clubRepository
        .readUserRecommendClubs()
        .then((value) => _userRecommendClubs = value.obs)
        .then((value) => _isLoadingRecommendClubs.value = false);
  }

  /* fetch Date */
  void fetchUserJoinClubs() {
    _isLoadingUserJoinClubs.value = true;
    clubRepository
        .readUserJoinClubs()
        .then((value) => _userJoinClubs.value = value)
        .then((_) => _isLoadingUserJoinClubs.value = false);
  }

  void fetchUserSchedules() {
    _isLoadingUserSchedules.value = true;
    clubRepository
        .readUserSchedules()
        .then((value) => _userSchedules.value = value)
        .then((value) => _isLoadingUserSchedules.value = false);
  }

  void fetchRecommendClubs() {
    _isLoadingRecommendClubs.value = true;
    clubRepository
        .readUserRecommendClubs()
        .then((value) => _userRecommendClubs.value = value)
        .then((value) => _isLoadingRecommendClubs.value = false);
  }

  /* Update Data */
  Future<bool> updateSchedule(int id, bool isAgree) async {
    bool isSuccess = await clubRepository.updateSchedule(id, isAgree);

    if (isSuccess) {
      _userSchedules.removeWhere((element) => element.id == id);
      Get.find<CalendarViewModel>()
          .updateScheduleByUpdatingSchedule(id, isAgree);
      return true;
    } else {
      return false;
    }
  }

  void updateScheduleByUpdatingPlan(int id, bool isAgree) {
    _userSchedules.removeWhere((element) => element.id == id);
  }
}
