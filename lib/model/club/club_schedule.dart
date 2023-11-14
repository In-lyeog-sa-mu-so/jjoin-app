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

  // yyyy-MM-dd HH:mm ~ yyyy-MM-dd HH:mm 형태로 리턴
  // 만약 날짜가 같다면 yyyy-MM-dd HH:mm ~ HH:mm 형태로 리턴
  String get date {
    String startDateStr = DateFormat('yyyy-MM-dd HH:mm').format(startDate);
    String endDateStr = DateFormat('yyyy-MM-dd HH:mm').format(endDate);

    print(startDateStr + " ~ " + endDateStr);
    if (startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day) {
      endDateStr = DateFormat('HH:mm').format(endDate);
    }

    return "$startDateStr ~ $endDateStr";
  }

  ClubSchedule copyWith({required bool isAgreed}) {
    return ClubSchedule(
      id: id,
      clubId: clubId,
      clubName: clubName,
      startDate: startDate,
      endDate: endDate,
      title: title,
      content: content,
      isParticipate: isAgreed,
    );
  }

  factory ClubSchedule.empty() {
    return ClubSchedule(
      id: 0,
      title: "일정이 없습니다.",
      content: "확정된 일정이 없습니다!!",
      startDate: DateTime.now(),
      endDate: DateTime.now(),
    );
  }

  factory ClubSchedule.fromJson({required Map<String, dynamic> json}) {
    // parse할때 ksT로 해야함
    return ClubSchedule(
      id: json["id"],
      clubId: json["clubId"],
      clubName: json["name"],
      startDate: DateTime.parse(json["startDate"]).toLocal(),
      endDate: DateTime.parse(json["endDate"]).toLocal(),
      title: json["title"],
      content: json["content"],
      isParticipate: json["isAgreed"],
    );
  }
}
