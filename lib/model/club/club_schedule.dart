class ClubSchedule {
  final int id;
  final String? clubName;
  final DateTime startDate;
  final DateTime endDate;
  final String title;
  final bool? isParticipate;

  ClubSchedule({
    required this.id,
    this.clubName,
    required this.startDate,
    required this.endDate,
    required this.title,
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
      clubName: clubName,
      startDate: startDate,
      endDate: endDate,
      title: title,
      isParticipate: isParticipate,
    );
  }
}
