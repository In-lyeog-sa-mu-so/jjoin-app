class User {
  final int userId;
  final String name;
  final String major;
  final String introduction;
  final String profileImageUuid;
  final int studentId;

  User({
    required this.userId,
    required this.name,
    required this.major,
    required this.introduction,
    required this.profileImageUuid,
    required this.studentId,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      userId: json['userId'],
      name: json['name'],
      major: json['major'],
      introduction: json['introduction'],
      profileImageUuid: json['profileImageUuid'],
      studentId: json['studentId'],
    );
  }
}

class JoinedClub {
  final int clubId;
  final String clubName;
  final String clubImage;

  JoinedClub({
    required this.clubId,
    required this.clubName,
    required this.clubImage,
  });

  factory JoinedClub.fromJson(Map<String, dynamic> json) {
    return JoinedClub(
      clubId: json['clubId'],
      clubName: json['clubName'],
      clubImage: json['clubImage'],
    );
  }
}

User user = User(
  userId: 1,
  name: "김동국",
  major: "컴퓨터공학과",
  introduction: "안녕하세요. 저는 동국대학교 컴퓨터공학과 21학번 김동국입니다.",
  profileImageUuid: "assets/images/jh_profile_image.png",
  studentId: 2019111989,
);

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
