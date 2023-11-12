class ClubPlanDetail {
  final int id;
  final String title;
  final String content;
  final DateTime startDate;
  final DateTime endDate;
  final DateTime createdDate;
  final DateTime updatedDate;
  final bool? isAgree;
  final int numberOfAgree;
  final int numberOfDisagree;

  ClubPlanDetail({
    required this.id,
    required this.title,
    required this.content,
    required this.startDate,
    required this.endDate,
    required this.updatedDate,
    required this.createdDate,
    this.isAgree,
    required this.numberOfAgree,
    required this.numberOfDisagree,
  });

  String get createdDateStr =>
      "${createdDate.year}년 ${createdDate.month}월 ${createdDate.day}일";
  String get updatedDateStr =>
      "${updatedDate.year}년 ${updatedDate.month}월 ${updatedDate.day}일";

  String get startDateStr =>
      "${startDate.year}년 ${startDate.month}월 ${startDate.day}일 ${startDate.hour}시 ${startDate.minute}분";
  String get endDateStr =>
      "${endDate.year}년 ${endDate.month}월 ${endDate.day}일 ${endDate.hour}시 ${endDate.minute}분";

  double get progress => (numberOfAgree + numberOfDisagree) != 0
      ? (numberOfAgree / (numberOfAgree + numberOfDisagree) * 100)
      : 0.0;

  ClubPlanDetail copyWith(
      {required bool isAgree,
      required int numberOfAgree,
      required int numberOfDisagree}) {
    return ClubPlanDetail(
      id: id,
      title: title,
      content: content,
      startDate: startDate,
      endDate: endDate,
      createdDate: createdDate,
      updatedDate: updatedDate,
      isAgree: isAgree,
      numberOfAgree: numberOfAgree,
      numberOfDisagree: numberOfDisagree,
    );
  }
}
