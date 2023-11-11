import 'package:jjoin/model/base/e_club_part.dart';

class ClubRecommend {
  final int id;
  final String imageURL;
  final String name;
  final String description;
  final int memberCnt;
  final EClubPart part;
  final List<String> tags;

  ClubRecommend({
    required this.id,
    required this.imageURL,
    required this.name,
    required this.description,
    required this.memberCnt,
    required this.part,
    required this.tags,
  });
}
