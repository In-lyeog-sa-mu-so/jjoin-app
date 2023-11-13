import 'package:get/get.dart';

import '../../model/club/club_plan_detail.dart';
import '../../repository/club/club_repository.dart';

class ClubPlanDetailViewModel extends GetxController {
  final int clubId;
  final int scheduleId;
  final ClubRepository clubRepository;

  late final Rx<ClubPlanDetail> _planDetail;
  final RxBool _isLoading = false.obs;
  ClubPlanDetail get planDetail => _planDetail.value;
  bool get isLoading => _isLoading.value;

  ClubPlanDetailViewModel({
    required this.clubId,
    required this.scheduleId,
    required this.clubRepository,
  })  : assert(scheduleId != null),
        assert(clubRepository != null);

  @override
  void onInit() {
    super.onInit();

    _initPlanDetail();
  }

  void _initPlanDetail() {
    _isLoading.value = true;
    _planDetail = clubRepository.getPlanDetail(clubId, scheduleId).obs;
    _isLoading.value = false;
  }

  void fetchPlanDetail() {
    _isLoading.value = true;
    _planDetail.value = clubRepository.getPlanDetail(clubId, scheduleId);
    _isLoading.value = false;
  }

  bool updateSchedule(int id, bool isAgree) {
    bool? beforeIsAgree = _planDetail.value.isAgree;
    bool isSuccess = true;

    if (isSuccess) {
      if (beforeIsAgree == null) {
        _planDetail.value = _planDetail.value.copyWith(
          isAgree: isAgree,
          numberOfAgree: isAgree
              ? _planDetail.value.numberOfAgree + 1
              : _planDetail.value.numberOfAgree,
          numberOfDisagree: isAgree
              ? _planDetail.value.numberOfDisagree
              : _planDetail.value.numberOfDisagree + 1,
        );
      } else if (beforeIsAgree != isAgree) {
        if (isAgree) {
          _planDetail.value = _planDetail.value.copyWith(
            isAgree: isAgree,
            numberOfAgree: _planDetail.value.numberOfAgree + 1,
            numberOfDisagree: _planDetail.value.numberOfDisagree - 1,
          );
        } else {
          _planDetail.value = _planDetail.value.copyWith(
            isAgree: isAgree,
            numberOfAgree: _planDetail.value.numberOfAgree - 1,
            numberOfDisagree: _planDetail.value.numberOfDisagree + 1,
          );
        }
      }
      return true;
    } else {
      return false;
    }
  }
}
