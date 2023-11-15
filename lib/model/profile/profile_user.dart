class User {
  final int id;
  final String name;
  final String major;
  final String introduction;
  final String profileImageUuid;
  final int studentId;

  User({
    required this.id,
    required this.name,
    required this.major,
    required this.introduction,
    required this.profileImageUuid,
    required this.studentId,
  });

  factory User.fromJson(
      {required Map<String, dynamic> json, required String imageUrl}) {
    return User(
      id: json['id'],
      name: json['name'],
      major: json['major'],
      introduction: json['introduction'],
      profileImageUuid: "$imageUrl/${json["profileImageUuid"]}",
      studentId: json['studentId'],
    );
  }

  factory User.empty() {
    return User(
      id: 0,
      name: "이름",
      major: "학과",
      introduction: "자기소개",
      profileImageUuid: "",
      studentId: 0,
    );
  }

  User copyWith({
    int? id,
    String? name,
    String? major,
    String? introduction,
    String? profileImageUuid,
    int? studentId,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      major: major ?? this.major,
      introduction: introduction ?? this.introduction,
      profileImageUuid: profileImageUuid ?? this.profileImageUuid,
      studentId: studentId ?? this.studentId,
    );
  }
}
