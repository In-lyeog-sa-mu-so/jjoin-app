class ClubNoticeDetail {
  final int id;
  final String title;
  final String content;
  final DateTime updatedDate;
  final DateTime createdDate;

  ClubNoticeDetail({
    required this.id,
    required this.title,
    required this.content,
    required this.updatedDate,
    required this.createdDate,
  });

  String get updatedDateStr =>
      "${updatedDate.year}년 ${updatedDate.month}월 ${updatedDate.day}일";
  String get createdDateStr =>
      "${createdDate.year}년 ${createdDate.month}월 ${createdDate.day}일";

  factory ClubNoticeDetail.fromJson({required json}) {
    return ClubNoticeDetail(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      updatedDate: DateTime.parse(json["updatedDate"]).toLocal(),
      createdDate: DateTime.parse(json["createdDate"]).toLocal(),
    );
  }
}
