import 'package:jjoin/model/base/e_club_part.dart';

class SearchClub {
  final int clubId;
  final String clubName;
  final String introduction;
  final int userNumber;
  final EClubPart part;
  final String profileImageUuid;
  final bool isFinished;
  final DateTime startDate;
  final DateTime endDate;

  SearchClub({
    required this.clubId,
    required this.clubName,
    required this.introduction,
    required this.userNumber,
    required this.part,
    required this.profileImageUuid,
    required this.isFinished,
    required this.startDate,
    required this.endDate,
  });
}
