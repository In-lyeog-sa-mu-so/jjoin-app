import 'package:get/get.dart';
import 'package:jjoin/repository/profile/profile_repository.dart';

import '../../model/profile/profile_joined_club.dart';
import '../../model/profile/profile_user.dart';

class ProfileViewModel extends GetxController {
  final ProfileRepository profileRepository;

  ProfileViewModel({required this.profileRepository})
      : assert(profileRepository != null);

  final Rx<User?> _user = Rx<User?>(null);
  final RxBool _isLoadingUser = false.obs;
  User? get user => _user.value;
  bool get isLoadingUser => _isLoadingUser.value;

  final RxList<JoinedClub> _joinedClubs = RxList();
  final RxBool _isLoadingJoinedClubs = false.obs;
  List<JoinedClub> get joinedClubs => _joinedClubs;
  bool get isLoadingJoinedClubs => _isLoadingJoinedClubs.value;

  final RxBool _isPushNotificationEnabled = false.obs;
  bool get isPushNotificationEnabled => _isPushNotificationEnabled.value;
  set isPushNotificationEnabled(bool value) =>
      _isPushNotificationEnabled.value = value;

  @override
  void onInit() {
    super.onInit();
    fetchUser();
    fetchJoinedClubs();
  }

  void fetchUser() {
    _isLoadingUser.value = true;
    _user.value = profileRepository.getUser();
    _isLoadingUser.value = false;
  }

  void fetchJoinedClubs() {
    _isLoadingJoinedClubs.value = true;
    _joinedClubs.value = profileRepository.getClubs();
    _isLoadingJoinedClubs.value = false;
  }

  void togglePushNotification(bool value) {
    isPushNotificationEnabled = value;
  }
}
