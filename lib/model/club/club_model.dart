import 'package:jjoin/model/base/e_club_part.dart';

class ClubModel {
  final int id;
  final String name;
  final List<String> tags;
  final String introduction;
  final String leaderName;
  final int memberCnt;
  final EClubPart part;
  final String profileImageUrl;
  final String backgroundImageUrl;
  final DateTime createdDate;
  final DateTime? startRecentJoinedDate;
  final DateTime? endRecentJoinedDate;

  ClubModel({
    required this.id,
    required this.name,
    required this.tags,
    required this.introduction,
    required this.leaderName,
    required this.memberCnt,
    required this.part,
    required this.profileImageUrl,
    required this.backgroundImageUrl,
    required this.createdDate,
    this.startRecentJoinedDate,
    this.endRecentJoinedDate,
  });

  factory ClubModel.fromJson(
      {required Map<String, dynamic> json, required String imageUrl}) {
    return ClubModel(
      id: json['id'],
      name: json['name'],
      tags: json['tags'].cast<String>(),
      introduction: json['introduction'],
      leaderName: json['leaderName'],
      memberCnt: json['numberOfMembers'],
      part: EClubPart.fromString(json['dependent']),
      profileImageUrl: "$imageUrl/${json["profileImageUuid"]}",
      backgroundImageUrl: "$imageUrl/${json["backgroundImageUuid"]}",
      createdDate: DateTime.parse(json["createdDate"]).toLocal(),
      startRecentJoinedDate: json['startDate']?.isEmpty ?? true
          ? null
          : DateTime.parse(json["startDate"]).toLocal(),
      endRecentJoinedDate: json['endDate']?.isEmpty ?? true
          ? null
          : DateTime.parse(json["endDate"]).toLocal(),
    );
  }

  factory ClubModel.empty() {
    return ClubModel(
      id: 0,
      name: "",
      tags: [],
      introduction: "",
      leaderName: "",
      memberCnt: 0,
      part: EClubPart.NONE,
      profileImageUrl: "",
      backgroundImageUrl: "",
      createdDate: DateTime.now(),
    );
  }

  bool get existRecentJoinedDate =>
      startRecentJoinedDate != null && endRecentJoinedDate != null;

  // 오늘을 기준으로 모집 기간이 지났는지 확인
  bool get isRecruiting {
    if (startRecentJoinedDate == null || endRecentJoinedDate == null) {
      return false;
    }

    DateTime now = DateTime.now().toLocal();
    return now.isAfter(startRecentJoinedDate!) &&
        now.isBefore(endRecentJoinedDate!);
  }

  String get createdDateStr => "${createdDate.year}년 ${createdDate.month}월";

  String get recentJoinedDate {
    if (startRecentJoinedDate == null || endRecentJoinedDate == null) {
      return "아직 모집을 시작하지 않았어요!!";
    }

    String startRecentJoinedDateStr =
        "${startRecentJoinedDate!.year}년 ${startRecentJoinedDate!.month}월 ${startRecentJoinedDate!.day}일";
    String endRecentJoinedDateStr =
        "${endRecentJoinedDate!.year}년 ${endRecentJoinedDate!.month}월 ${endRecentJoinedDate!.day}일";

    if (startRecentJoinedDate!.year == endRecentJoinedDate!.year) {
      return "$startRecentJoinedDateStr ~ ${endRecentJoinedDate!.month}월 ${endRecentJoinedDate!.day}일";
    }

    return "$startRecentJoinedDateStr ~ $endRecentJoinedDateStr";
  }
}
