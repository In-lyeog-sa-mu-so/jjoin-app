import 'dart:io';

import 'package:get/get.dart';
import 'package:jjoin/viewmodel/profile/profile_viewmodel.dart';
import '../../model/profile/profile_user.dart';
import '../../repository/profile/profile_repository.dart';

class ProfileEditViewModel extends GetxController {
  final ProfileRepository profileRepository;

  ProfileEditViewModel({
    required this.profileRepository,
  });

  late final Rx<User> _userInfo;
  late final RxBool _isLoadingUserInfo;
  User get userInfo => _userInfo.value;
  bool get isLoadingUserInfo => _isLoadingUserInfo.value;

  late final RxBool _isEditingText;
  bool get isEditingText => _isEditingText.value;

  late final Rx<File> _newImage;
  File get newImage => _newImage.value;
  set newImage(File value) => _newImage.value = value;

  void startEditing() {
    _isEditingText.value = true;
  }

  void saveImage(File uploadImage) {
    _newImage.value = uploadImage;
  }

  void saveProfile(String introduction) async {
    bool shouldUpdateImage =
        _newImage.value != null && _newImage.value.path.isNotEmpty;
    bool shouldUpdateIntroduction = introduction.isNotEmpty;

    if (shouldUpdateImage || shouldUpdateIntroduction) {
      bool result = await profileRepository.saveUserProfile(
        shouldUpdateImage
            ? _newImage.value
            : null, // Pass null if no image is to be updated
        introduction,
      );
      print(_newImage.value);
      if (result) {
        await fetchUserInfo();
        Get.find<ProfileViewModel>().fetchUserInfo();
        // You may want to update the user interface or provide a success message
      } else {
        Get.snackbar('Error', '프로필 업데이트 실패');
      }
    } else {
      Get.snackbar('Error', '업데이트할 데이터가 없습니다.');
    }
  }

  @override
  void onInit() {
    _isEditingText = false.obs;
    _newImage = File('').obs;
    _isLoadingUserInfo = false.obs;

    super.onInit();

    initUserInfo();
  }

  void initUserInfo() {
    _isLoadingUserInfo.value = true;
    profileRepository
        .readUserInfo()
        .then((value) => _userInfo = value.obs)
        .then((_) => _isLoadingUserInfo.value = false);
  }

  Future<void> fetchUserInfo() async {
    _isLoadingUserInfo.value = true;
    var value = await profileRepository.readUserInfo();
    _userInfo.value = value;
    update(); // UI를 갱신하기 위해 GetX의 update() 호출
    _isLoadingUserInfo.value = false;
  }
}
