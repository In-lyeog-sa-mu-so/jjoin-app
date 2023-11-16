class Questions {
  final int id;
  final String content;

  Questions({
    required this.id,
    required this.content,
  });

  factory Questions.fromJson(Map<String, dynamic> json) {
    return Questions(
      id: json['id'],
      content: json['content'],
    );
  }

  factory Questions.empty() {
    return Questions(
      id: 0,
      content: "질문이 없습니다.",
    );
  }
}
