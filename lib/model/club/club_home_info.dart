import 'package:jjoin/model/base/e_club_part.dart';

class ClubHomeInfo {
  final int id;
  final String imageURL;
  final String name;
  final String description;
  final String leaderName;
  final int memberCnt;
  final EClubPart part;
  final String recentNotice;

  ClubHomeInfo({
    required this.id,
    required this.imageURL,
    required this.name,
    required this.description,
    required this.leaderName,
    required this.memberCnt,
    required this.part,
    required this.recentNotice,
  });
}
