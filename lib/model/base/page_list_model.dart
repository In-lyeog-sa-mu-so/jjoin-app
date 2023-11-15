import 'package:jjoin/model/base/page_info.dart';

class PageListModel<T> {
  PageInfo pageInfo;
  List<T> dataList;

  PageListModel({
    required this.pageInfo,
    required this.dataList,
  });
}
