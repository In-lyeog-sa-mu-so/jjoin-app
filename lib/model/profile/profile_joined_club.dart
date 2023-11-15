class JoinedClub {
  final int id;
  final String name;
  final String clubImageUuid;

  JoinedClub({
    required this.id,
    required this.name,
    required this.clubImageUuid,
  });

  factory JoinedClub.fromJson(
      {required Map<String, dynamic> json, required String imageUrl}) {
    return JoinedClub(
      id: json['id'],
      name: json['name'],
      clubImageUuid: "$imageUrl/${json['clubImageUuid']}",
    );
  }

  factory JoinedClub.empty() {
    return JoinedClub(
      id: 0,
      name: "가입한 동아리가 없습니다.\n동아리를 찾아보세요!",
      clubImageUuid: "",
    );
  }
}
