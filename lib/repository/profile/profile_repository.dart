import 'package:jjoin/provider/profile/profile_local_provider.dart';

import '../../model/profile/profile_joined_club.dart';
import '../../model/profile/profile_user.dart';
import '../../provider/Profile/profile_remote_provider.dart';

class ProfileRepository {
  final ProfileLocalProvider profileLocalProvider;
  final ProfileRemoteProvider profileRemoteProvider;

  ProfileRepository(
      {required this.profileLocalProvider, required this.profileRemoteProvider})
      : assert(profileRemoteProvider != null || profileLocalProvider != null);

  User getUser() {
    return profileLocalProvider.getDummyUser();
  }

  List<JoinedClub> getClubs() {
    return profileLocalProvider.getDummyClubs();
  }
}
