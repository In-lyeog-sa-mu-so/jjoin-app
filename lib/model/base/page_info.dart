class PageInfo {
  // 현재 페이지
  int currentPage;
  // 페이지당 데이터 수
  final int pageSize;
  // 총 페이지 수
  final int totalPage;
  final int totalData;

  PageInfo({
    required this.currentPage,
    required this.pageSize,
    required this.totalPage,
    required this.totalData,
  });

  bool get hasPreviousPage => currentPage > 1;
  bool get hasNextPage => currentPage < totalPage;
}
