import 'package:jjoin/model/base/e_club_part.dart';

class ClubHomeInfo {
  final int id;
  final String name;
  final String introduction;
  final String imageUuid;
  final String leaderName;
  final int memberCnt;
  final EClubPart part;
  final String recentNotice;

  ClubHomeInfo({
    required this.id,
    required this.name,
    required this.introduction,
    required this.imageUuid,
    required this.leaderName,
    required this.memberCnt,
    required this.part,
    required this.recentNotice,
  });

  factory ClubHomeInfo.fromJson(
      {required Map<String, dynamic> json, required String imageUrl}) {
    return ClubHomeInfo(
      id: json["id"],
      name: json["name"],
      introduction: json["introduction"],
      imageUuid: "$imageUrl/${json["profileImageUuid"]}",
      leaderName: json["leaderName"],
      memberCnt: json["numberOfMembers"],
      part: EClubPart.fromString(json["dependent"]),
      recentNotice: json["newestNotice"],
    );
  }

  factory ClubHomeInfo.empty() {
    return ClubHomeInfo(
      id: 0,
      name: "가입한 동아리가 없습니다.",
      introduction: "동아리를 찾아보세요!",
      imageUuid: "",
      leaderName: "",
      memberCnt: 0,
      part: EClubPart.fromString("없음"),
      recentNotice: "",
    );
  }
}
