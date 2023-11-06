import '../model/profile_user.dart';

class ProfileRepository {
  static User getDummyUser() {
    return User(
      userId: 1,
      name: "박재형",
      major: "컴퓨터공학과",
      introduction: "안녕하세요. 저는 동국대학교 컴퓨터공학과 19학번 박재형입니다.\nasdsda\nasdasd",
      profileImageUuid: "assets/images/jh_profile_image.png",
      studentId: 2019111989,
    );
  }
}