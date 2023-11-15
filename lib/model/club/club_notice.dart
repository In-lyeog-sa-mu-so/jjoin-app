class ClubNotice {
  final int id;
  final String title;
  final String content;
  final DateTime updateDate;

  ClubNotice({
    required this.id,
    required this.title,
    required this.content,
    required this.updateDate,
  });

  String get date {
    return "${updateDate.year}-${updateDate.month}-${updateDate.day}";
  }

  factory ClubNotice.fromJson({required json}) {
    return ClubNotice(
      id: json["id"],
      title: json["title"],
      content: json["content"],
      updateDate: DateTime.parse(json["updatedDate"]).toLocal(),
    );
  }

  factory ClubNotice.empty() {
    return ClubNotice(
      id: 0,
      title: "공지사항이 없습니다.",
      content: "공지사항이 없습니다!!",
      updateDate: DateTime.now(),
    );
  }
}
