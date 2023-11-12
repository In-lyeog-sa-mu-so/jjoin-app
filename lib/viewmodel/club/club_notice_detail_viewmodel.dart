import 'package:get/get.dart';
import 'package:jjoin/model/club/club_notice_detail.dart';
import 'package:jjoin/repository/club/club_repository.dart';

class ClubNoticeDetailViewModel extends GetxController {
  final int clubId;
  final int noticeId;
  final ClubRepository clubRepository;

  ClubNoticeDetailViewModel({
    required this.clubId,
    required this.noticeId,
    required this.clubRepository,
  }) : assert(clubRepository != null);

  final RxBool _isLoading = false.obs;
  late final Rx<ClubNoticeDetail> _noticeDetail;
  bool get isLoading => _isLoading.value;
  ClubNoticeDetail get noticeDetail => _noticeDetail.value;

  @override
  void onInit() {
    super.onInit();
    fetchNoticeDetail(noticeId);
  }

  void fetchNoticeDetail(int id) {
    _isLoading.value = true;
    _noticeDetail = clubRepository.getClubNoticeDetail(id).obs;
    _isLoading.value = false;
  }
}
