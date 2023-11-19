import 'dart:ffi';

class Tag {
  final int id;
  final String name;

  Tag({
    required this.id,
    required this.name,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
    );
  }

  factory Tag.empty() {
    return Tag(
      id: 0,
      name: "태그가 없습니다.",
    );
  }
}

class PageInfo {
  final int page;
  final int size;
  final int totalElements;
  final int totalPages;

  PageInfo({
    required this.page,
    required this.size,
    required this.totalElements,
    required this.totalPages,
  });

  factory PageInfo.fromJson({required Map<String, dynamic> json}) {
    return PageInfo(
      page: json['page'],
      size: json['size'],
      totalElements: json['totalElements'],
      totalPages: json['totalPages'],
    );
  }

  factory PageInfo.empty() {
    return PageInfo(
      page: 0,
      size: 0,
      totalElements: 0,
      totalPages: 0,
    );
  }
}
