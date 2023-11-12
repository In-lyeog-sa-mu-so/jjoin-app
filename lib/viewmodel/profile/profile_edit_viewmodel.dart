import 'dart:io';

import 'package:get/get.dart';

import '../../model/profile/profile_user.dart';
import '../../repository/profile/profile_repository.dart';

class ProfileEditViewModel extends GetxController {
  final ProfileRepository profileRepository;

  ProfileEditViewModel({
    required this.profileRepository,
  }) : assert(profileRepository != null);

  final Rx<User?> _user = Rx<User?>(null);
  final RxBool _isLoadingUser = false.obs;
  User? get user => _user.value;
  bool get isLoadingUser => _isLoadingUser.value;

  final RxBool _isEditingText = false.obs;
  bool get isEditingText => _isEditingText.value;

  final Rx<File?> _profileImage = Rx<File?>(null);
  File? get profileImage => _profileImage.value;

  void updateProfileImage(File? newImage) {
    _profileImage.value = newImage;
  }

  void startEditing() {
    _isEditingText.value = true;
  }

  void saveProfile(String introduction, File? profileImage) {
    if (isLoadingUser) return; // Don't proceed if user data is still loading
    // Logic to handle saving the profile
    if (user != null) {
      // Update the user's introduction
      user!.introduction = introduction;
      // If a new profile image was picked, update it
      if (profileImage != null) {
        // You'd typically handle file uploading here, then update the user's profile image URL
        // For example, upload the file and on success update user's profileImageUuid
      }
      //TODO
      // profileRepository.saveUserProfile(user!);
    }
    _isEditingText.value = false; // Stop editing mode after save
    // Make sure to update all listeners that the user has been updated
    update();
  }

  @override
  void onInit() {
    super.onInit();
    fetchUser();
  }

  void fetchUser() {
    _isLoadingUser.value = true;
    _user.value = profileRepository.getUser();
    _isLoadingUser.value = false;
  }
}
