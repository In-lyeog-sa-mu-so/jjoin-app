import 'package:get/get.dart';
import 'package:jjoin/repository/profile/profile_repository.dart';

import '../../model/profile/profile_joined_club.dart';
import '../../model/profile/profile_user.dart';

class ProfileViewModel extends GetxController {
  final ProfileRepository profileRepository;

  ProfileViewModel({required this.profileRepository});

  /* User Profile */
  late final Rx<User> _userInfo;
  late final RxBool _isLoadingUserInfo;
  User get userInfo => _userInfo.value;
  bool get isLoadingUserInfo => _isLoadingUserInfo.value;

  /* Club Joined */
  late final RxList<JoinedClub> _joinedClubs;
  late final RxBool _isLoadingJoinedClubs;
  List<JoinedClub> get joinedClubs => _joinedClubs;
  bool get isLoadingJoinedClubs => _isLoadingJoinedClubs.value;

  final RxBool _isPushNotificationEnabled = false.obs;
  bool get isPushNotificationEnabled => _isPushNotificationEnabled.value;
  set isPushNotificationEnabled(bool value) =>
      _isPushNotificationEnabled.value = value;

  @override
  void onInit() {
    _isLoadingUserInfo = false.obs;
    _isLoadingJoinedClubs = false.obs;

    super.onInit();

    initUserInfo();
    initJoinedClubs();
  }

  void initUserInfo() {
    _isLoadingUserInfo.value = true;
    profileRepository
        .readUserInfo()
        .then((value) => _userInfo = value.obs)
        .then((_) => _isLoadingUserInfo.value = false);
  }

  void initJoinedClubs() {
    _isLoadingJoinedClubs.value = true;
    profileRepository
        .readUserJoinClubs()
        .then((value) => _joinedClubs = value.obs)
        .then((value) => _isLoadingJoinedClubs.value = false);
  }

  void fetchUserInfo() {
    _isLoadingUserInfo.value = true;
    profileRepository
        .readUserInfo()
        .then((value) => _userInfo.value = value)
        .then((_) => _isLoadingUserInfo.value = false);
  }

  void fetchJoinedClubs() {
    _isLoadingJoinedClubs.value = true;
    profileRepository
        .readUserJoinClubs()
        .then((value) => _joinedClubs.value = value)
        .then((value) => _isLoadingJoinedClubs.value = false);
  }

  void togglePushNotification(bool value) {
    isPushNotificationEnabled = value;
  }
}
