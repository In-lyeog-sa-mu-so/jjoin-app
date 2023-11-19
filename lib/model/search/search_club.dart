import 'package:jjoin/model/base/e_club_part.dart';

class SearchClub {
  final int clubId;
  final String clubName;
  final String introduction;
  final int userNumber;
  final EClubPart dependent;
  final String profileImageUuid;
  final bool isFinished;
  final DateTime startDate;
  final DateTime endDate;
  final String leaderName;

  SearchClub({
    required this.clubId,
    required this.clubName,
    required this.introduction,
    required this.userNumber,
    required this.dependent,
    required this.profileImageUuid,
    required this.isFinished,
    required this.startDate,
    required this.endDate,
    required this.leaderName,
  });

  factory SearchClub.fromJson(
      {required Map<String, dynamic> json, required String imageUrl}) {
    return SearchClub(
      clubId:
          json['clubId'] ?? 0, // Assuming clubId is also a non-nullable field.
      clubName:
          json['clubName'] ?? 'Unknown', // Provide a default value if null.
      introduction: json['introduction'] ?? 'No introduction provided.',
      userNumber: json['userNumber'] ??
          0, // Assuming userNumber is a non-nullable field.
      dependent: EClubPart.fromString(json['dependent'] ??
          'default_value'), // Provide a default or handle null.
      profileImageUuid: json['profileImageUuid'] != null
          ? "$imageUrl/${json['profileImageUuid']}"
          : 'default_image.png',
      isFinished: json['isFinished'] ??
          false, // Already handled in your previous snippet.
      startDate: json["startDate"] != null
          ? DateTime.parse(json["startDate"]).toLocal()
          : DateTime.now(),
      endDate: json["endDate"] != null
          ? DateTime.parse(json["endDate"]).toLocal()
          : DateTime.now(),
      leaderName: json['leaderName'] ?? 'No leader',
    );
  }

  factory SearchClub.empty() {
    return SearchClub(
      clubId: 0,
      clubName: "동아리가 없습니다.",
      introduction: "동아리를 찾아보세요!",
      userNumber: 0,
      dependent: EClubPart.CENTRAL,
      profileImageUuid: "",
      isFinished: false,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      leaderName: "",
    );
  }
}

class PageInfo {
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  PageInfo({
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  factory PageInfo.fromJson({required Map<String, dynamic> json}) {
    return PageInfo(
      page: json['page'],
      size: json['size'],
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
    );
  }

  factory PageInfo.empty() {
    return PageInfo(
      page: 0,
      size: 0,
      totalElements: 0,
      totalPages: 0,
    );
  }
}
