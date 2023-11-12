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
}
