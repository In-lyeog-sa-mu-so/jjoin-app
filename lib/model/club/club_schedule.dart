import 'package:intl/intl.dart';

class ClubSchedule {
  final int id;
  final int? clubId;
  final String? clubName;
  final DateTime startDate;
  final DateTime endDate;
  final String title;
  final String content;
  final bool? isParticipate;

  ClubSchedule({
    required this.id,
    this.clubId,
    this.clubName,
    required this.startDate,
    required this.endDate,
    required this.title,
    required this.content,
    this.isParticipate,
  });

  // yyyy-MM-dd HH시 mm분 ~ yyyy-MM-dd HH시 mm분 형태로 리턴
  // 만약 날짜가 같다면 yyyy-MM-dd HH시 mm분 ~ HH시 mm분 형태로 리턴
  String get date {
    String startDateString = DateFormat('yyyy-MM-dd HH시 mm분').format(startDate);
    String endDateString = DateFormat('yyyy-MM-dd HH시 mm분').format(endDate);

    if (startDateString.substring(0, 10) == endDateString.substring(0, 10)) {
      return "${startDateString.substring(0, 10)} ${startDateString.substring(11, 16)} ~ ${endDateString.substring(11, 16)}";
    } else {
      return "$startDateString ~ $endDateString";
    }
  }

  ClubSchedule copyWith({required bool isParticipate}) {
    return ClubSchedule(
      id: id,
      clubId: clubId,
      clubName: clubName,
      startDate: startDate,
      endDate: endDate,
      title: title,
      content: content,
      isParticipate: isParticipate,
    );
  }

  factory ClubSchedule.fromJson({required Map<String, dynamic> json}) {
    return ClubSchedule(
      id: json["id"],
      clubId: json["clubId"],
      clubName: json["name"],
      startDate: DateTime.parse(json["startDate"]),
      endDate: DateTime.parse(json["endDate"]),
      title: json["title"],
      content: json["content"],
      isParticipate: json["isParticipate"],
    );
  }
}
