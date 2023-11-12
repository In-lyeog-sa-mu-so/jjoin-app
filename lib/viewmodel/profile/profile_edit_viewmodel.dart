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

  final Rx<File?> _newImage = Rx<File?>(null);
  File? get newImage => _newImage.value;

  void updateProfileImage(File? newImage) {
    _newImage.value = newImage;
  }

  void startEditing() {
    _isEditingText.value = true;
  }

  void saveProfile(String introduction, File? newImage) {
    if (isLoadingUser) return; // Don't proceed if user data is still loading
    // Logic to handle saving the profile
    if (introduction != null) {
      // Update the user's introduction
      print(introduction);
    }
    if (newImage != null) {
      // You'd typically handle file uploading here, then update the user's profile image URL
      // For example, upload the file and on success update user's profileImageUuid
      print(newImage.path);
    }
    //TODO
    // profileRepository.saveUserProfile(user!);
    _isEditingText.value = false;
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
