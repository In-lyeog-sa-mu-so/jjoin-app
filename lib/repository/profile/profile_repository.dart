import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jjoin/provider/profile/profile_local_provider.dart';
import 'package:jjoin/provider/profile/profile_provider.dart';

import '../../model/profile/profile_joined_club.dart';
import '../../model/profile/profile_user.dart';

class ProfileRepository {
  static final String _imageUrl = dotenv.env['JJOIN_IMAGE_SERVER_URL']!;
  final ProfileLocalProvider profileLocalProvider;
  final ProfileProvider profileProvider;

  ProfileRepository({
    required this.profileLocalProvider,
    required this.profileProvider,
  });

  Future<User> readUserInfo() async {
    Map<String, dynamic> data = await profileProvider.getUserInfo();
    if (data.isEmpty) {
      return User.empty();
    } else {
      return User.fromJson(json: data, imageUrl: _imageUrl);
    }
  }

  Future<List<JoinedClub>> readUserJoinClubs() async {
    Map<String, dynamic> data = await profileProvider.getJoinClubs();
    var result = data["data"]
        .map<JoinedClub>(
            (json) => JoinedClub.fromJson(json: json, imageUrl: _imageUrl))
        .toList();
    if (result.length == 0) {
      result.add(JoinedClub.empty());
    }
    return result;
  }

  Future<bool> saveUserProfile(
      dynamic uploadImage, dynamic introduction) async {
    return await profileProvider.putUserProfileImage(uploadImage, introduction);
  }
}
