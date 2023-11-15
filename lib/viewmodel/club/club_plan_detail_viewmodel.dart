import 'package:get/get.dart';
import 'package:jjoin/viewmodel/calendar/calendar_viewmodel.dart';
import 'package:jjoin/viewmodel/club/club_viewmodel.dart';

import '../../model/club/club_plan_detail.dart';
import '../../repository/club/club_repository.dart';
import '../home/home_viewmodel.dart';

class ClubPlanDetailViewModel extends GetxController {
  final int clubId;
  final int scheduleId;
  final ClubRepository clubRepository;

  late final RxBool _isLoading;
  late final Rx<ClubPlanDetail> _planDetail;
  ClubPlanDetail get planDetail => _planDetail.value;
  bool get isLoading => _isLoading.value;

  ClubPlanDetailViewModel({
    required this.clubId,
    required this.scheduleId,
    required this.clubRepository,
  });

  @override
  void onInit() {
    super.onInit();

    _isLoading = false.obs;
    _initPlanDetail();
  }

  void _initPlanDetail() {
    _isLoading.value = true;
    clubRepository.readPlanDetail(clubId, scheduleId).then((value) {
      _planDetail = value.obs;
    }).whenComplete(() {
      _isLoading.value = false;
    });
  }

  Future<bool> updateSchedule(int id, bool isAgree) async {
    bool? beforeIsAgree = _planDetail.value.isAgree;
    bool isSuccess = await clubRepository.updateSchedule(id, isAgree);

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

      Get.find<HomeViewModel>().updateScheduleByUpdatingPlan(id, isAgree);
      Get.find<CalendarViewModel>()
          .updateScheduleByUpdatingSchedule(id, isAgree);
      Get.find<ClubViewModel>().updateScheduleByUpdate(id, isAgree);
      return true;
    } else {
      return false;
    }
  }
}
