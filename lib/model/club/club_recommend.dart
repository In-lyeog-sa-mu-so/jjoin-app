import 'package:jjoin/model/base/e_club_part.dart';

class ClubRecommend {
  final int id;
  final String name;
  final String introduction;
  final String imageUrl;
  final int memberCnt;
  final EClubPart part;
  final List<String> tags;

  ClubRecommend({
    required this.id,
    required this.name,
    required this.introduction,
    required this.imageUrl,
    required this.memberCnt,
    required this.part,
    required this.tags,
  });

  factory ClubRecommend.fromJson({required json, required String imageUrl}) {
    return ClubRecommend(
      id: json["id"],
      name: json["name"],
      introduction: json["introduction"],
      imageUrl: "$imageUrl/${json["profileImageUuid"]}",
      memberCnt: json["numberOfMembers"],
      part: EClubPart.fromString(json["dependent"]),
      tags: json["tags"].cast<String>(),
    );
  }

  factory ClubRecommend.empty() {
    return ClubRecommend(
      id: 0,
      name: "추천할 동아리가 없어요...ㅠㅠ",
      introduction: "동아리를 찾아보세요!",
      imageUrl: "",
      memberCnt: 0,
      part: EClubPart.fromString("없음"),
      tags: [],
    );
  }
}
