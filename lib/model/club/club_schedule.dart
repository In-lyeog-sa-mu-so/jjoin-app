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
    String start =
        "${startDate.year}-${startDate.month}-${startDate.day} ${startDate.hour}:${startDate.minute}";
    String end =
        "${endDate.year}-${endDate.month}-${endDate.day} ${endDate.hour}:${endDate.minute}";

    if (startDate.year == endDate.year &&
        startDate.month == endDate.month &&
        startDate.day == endDate.day) {
      return "$start ~ ${endDate.hour}:${endDate.minute}";
    }

    return "$start ~ $end";
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
