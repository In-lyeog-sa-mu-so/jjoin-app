import 'package:get/get.dart';
import 'package:jjoin/model/club/club_recommend.dart';
import 'package:jjoin/repository/club/club_repository.dart';

import '../../model/club/club_home_info.dart';
import '../../model/club/club_schedule.dart';

class HomeViewModel extends GetxController {
  final ClubRepository clubRepository;

  HomeViewModel({required this.clubRepository})
      : assert(clubRepository != null);

  /* Club Home Info */
  final RxList<ClubHomeInfo> _clubHomeInfos = RxList();
  final RxBool _isLoadingClubHomeInfos = false.obs;
  List<ClubHomeInfo> get clubHomeInfos => _clubHomeInfos;
  bool get isLoadingClubHomeInfos => _isLoadingClubHomeInfos.value;

  /* Club Schedules */
  final RxList<ClubSchedule> _schedules = RxList();
  final RxBool _isLoadingSchedules = false.obs;
  List<ClubSchedule> get schedules => _schedules;
  bool get isLoadingSchedules => _isLoadingSchedules.value;

  /* Club Recommend */
  final RxList<ClubRecommend> _clubRecommends = RxList();
  final RxBool _isLoadingClubRecommends = false.obs;
  List<ClubRecommend> get clubRecommends => _clubRecommends;
  bool get isLoadingClubRecommends => _isLoadingClubRecommends.value;

  @override
  void onInit() {
    super.onInit();

    // _isLoadingClubHomeInfos.value = true;
    // _clubHomeInfos.value = clubRepository.getHomeMyClubInfos();
    // _isLoadingClubHomeInfos.value = false;

    _isLoadingSchedules.value = true;
    _schedules.value = clubRepository.getHomeClubSchedule();
    _isLoadingSchedules.value = false;

    // _isLoadingClubRecommends.value = true;
    // _clubRecommends.value = clubRepository.getHomeClubRecommends();
    // _isLoadingClubRecommends.value = false;
  }

  void fetchClubHomeInfos() {
    // _isLoadingClubHomeInfos.value = true;
    // _clubHomeInfos.value = clubRepository.getHomeMyClubInfos();
    // _isLoadingClubHomeInfos.value = false;
  }

  void fetchSchedules() {
    _isLoadingSchedules.value = true;
    _schedules.value = clubRepository.getHomeClubSchedule();
    _isLoadingSchedules.value = false;
  }

  void fetchClubRecommends() {
    // _isLoadingClubRecommends.value = true;
    // _clubRecommends.value = clubRepository.getHomeClubRecommends();
    // _isLoadingClubRecommends.value = false;
  }
}
