class SearchClub {
  final int clubId;
  final String clubName;
  final String introduction;
  final int userNumber;
  final String? dependent;
  final String profileImageUuid;
  final bool isFinished;
  final DateTime startDate;
  final DateTime endDate;

  SearchClub({
    required this.clubId,
    required this.clubName,
    required this.introduction,
    required this.userNumber,
    this.dependent,
    required this.profileImageUuid,
    required this.isFinished,
    required this.startDate,
    required this.endDate,
  });

  factory SearchClub.fromJson(Map<String, dynamic> json) {
    return SearchClub(
      clubId: json['clubId'],
      clubName: json['clubName'],
      introduction: json['introduction'],
      userNumber: json['userNumber'],
      dependent: json['dependent'],
      profileImageUuid: json['profileImageUuid'],
      isFinished: json['isFinished'],
      startDate: DateTime.parse(json['startDate']),
      endDate: DateTime.parse(json['endDate']),
    );
  }
}

List<SearchClub> clubs = [
  SearchClub(
    clubId: 1,
    clubName: "음샘",
    introduction: "밴드 음악을 하고 있는 중앙동아리 음샘입니다.",
    userNumber: 20,
    dependent: "동국대학교 중앙동아리",
    profileImageUuid: "", // 실제 이미지 경로나 Base64 인코딩된 데이터로 가정
    isFinished: false,
    startDate: DateTime.parse("2023-08-01"),
    endDate: DateTime.parse("2023-08-31"),
  ),
  SearchClub(
    clubId: 2,
    clubName: "세미콜론",
    introduction: "동국대학교 컴공 학생회의 축구 소모임 세미콜론입니다.",
    userNumber: 30,
    dependent: "동국대학교 컴퓨터공학과 소모임",
    profileImageUuid: "", // 실제 이미지 경로나 Base64 인코딩된 데이터로 가정
    isFinished: true,
    startDate: DateTime.parse("2023-11-01"),
    endDate: DateTime.parse("2023-11-30"),
  ),
  SearchClub(
    clubId: 3,
    clubName: "GDSC",
    introduction: "동국대학교 컴공 학생회의 축구 소모임 세미콜론입니다.",
    userNumber: 30,
    dependent: "동국대학교 컴퓨터공학과 소모임",
    profileImageUuid: "", // 실제 이미지 경로나 Base64 인코딩된 데이터로 가정
    isFinished: true,
    startDate: DateTime.parse("2023-11-01"),
    endDate: DateTime.parse("2023-11-30"),
  ),
  SearchClub(
      clubId: 4,
      clubName: "멋쟁이 사자처럼",
      introduction: "동국대학교 컴공 학생회의 축구 소모임 세미콜론입니다.",
      userNumber: 30,
      dependent: "동국대학교 컴퓨터공학과 소모임",
      profileImageUuid: "", // 실제 이미지 경로나 Base64 인코딩된 데이터로 가정
      isFinished: true,
      startDate: DateTime.parse("2023-11-01"),
  endDate: DateTime.parse("2023-11-30"),
  ),
];