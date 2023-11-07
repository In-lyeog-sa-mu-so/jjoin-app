import 'package:dio/dio.dart';
import 'package:jjoin/model/SearchClub/search_club.dart';

class SearchClubProvider {
  //엔드포인트의 searchclub response body 를 가져오는 함수

  Future<List<SearchClub>> getClubs() async {
    Dio dio = Dio();
    Response response = await dio.get('/searchclub');
    try {
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        print('Failed to load searchclub');
        throw Exception('Failed to load searchclub');
      }
    } on DioError catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to load searchclub');
    }
  }

  Future<void> postSearchQuery(
      String keyword, List<String> tags, int page, int length) async {
    Dio dio = Dio();
    Response response = await dio.post('/searchclub', data: {
      'keyword': keyword,
      'tags': tags,
      'page': page,
      'length': length
    });
  }
}
