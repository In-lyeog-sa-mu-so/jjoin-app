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

  late final RxBool _isLoading;
  late final Rx<ClubNoticeDetail> _noticeDetail;
  bool get isLoading => _isLoading.value;
  ClubNoticeDetail get noticeDetail => _noticeDetail.value;

  @override
  void onInit() {
    super.onInit();
    _isLoading = false.obs;
    fetchNoticeDetail(clubId, noticeId);
  }

  void fetchNoticeDetail(int clubId, int id) {
    _isLoading.value = true;
    clubRepository.readClubNoticeDetail(clubId, id).then((value) {
      _noticeDetail = value.obs;
    }).whenComplete(() {
      _isLoading.value = false;
    });
  }
}
