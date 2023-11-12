import 'package:get/get.dart';
import 'package:jjoin/model/profile/profile_user.dart';

import '../../model/profile/profile_joined_club.dart';

class ProfileLocalProvider extends GetConnect {
  User getDummyUser() {
    return User(
      userId: 1,
      name: "박재형",
      major: "컴퓨터공학과",
      introduction: "안녕하세요. 저는 동국대학교 컴퓨터공학과 19학번 박재형입니다.",
      profileImageUuid: "assets/images/jh_profile_image.png",
      studentId: 2019111989,
    );
  }

  List<JoinedClub> getDummyClubs() {
    List<JoinedClub> joinedClubs = [
      JoinedClub(
        clubId: 1,
        clubName: "GDSC",
        clubImage: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        clubId: 2,
        clubName: "멋사",
        clubImage: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        clubId: 3,
        clubName: "음샘",
        clubImage: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        clubId: 4,
        clubName: "봉사 동아리",
        clubImage: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        clubId: 5,
        clubName: "컴공 학생회",
        clubImage: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        clubId: 6,
        clubName: "세미콜론",
        clubImage: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        clubId: 7,
        clubName: "언더바",
        clubImage: "assets/images/dgu_image.png",
      ),
    ];

    return joinedClubs;
  }
}
