import 'package:get/get.dart';
import 'package:jjoin/model/profile/profile_user.dart';

import '../../model/profile/profile_joined_club.dart';

class ProfileLocalProvider extends GetConnect {
  User getDummyUser() {
    return User(
      id: 1,
      name: "박재형",
      major: "컴퓨터공학과",
      introduction: "안녕하세요. 저는 동국대학교 컴퓨터공학과 19학번 박재형입니다.",
      profileImageUuid: "assets/images/jh_profile_image.png",
      //studentId: 2019111989,
    );
  }

  List<JoinedClub> getDummyClubs() {
    List<JoinedClub> joinedClubs = [
      JoinedClub(
        id: 1,
        name: "GDSC",
        clubImageUuid: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        id: 2,
        name: "멋사",
        clubImageUuid: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        id: 3,
        name: "음샘",
        clubImageUuid: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        id: 4,
        name: "봉사 동아리",
        clubImageUuid: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        id: 5,
        name: "컴공 학생회",
        clubImageUuid: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        id: 6,
        name: "세미콜론",
        clubImageUuid: "assets/images/dgu_image.png",
      ),
      JoinedClub(
        id: 7,
        name: "언더바",
        clubImageUuid: "assets/images/dgu_image.png",
      ),
    ];

    return joinedClubs;
  }
}
