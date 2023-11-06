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

User user =
  User(
  userId: 1,
  name: "김동국",
  major: "컴퓨터공학과",
  introduction: "안녕하세요. 저는 동국대학교 컴퓨터공학과 21학번 김동국입니다.",
  profileImageUuid: "assets/images/jh_profile_image.png",
  studentId: 2019111989,
  );

