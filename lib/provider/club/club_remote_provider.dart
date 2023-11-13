import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ClubRemoteProvider extends GetConnect {
  static final String _apiUrl = dotenv.env['JJOIN_API_SERVER_URL']!;

  Future<Map<String, dynamic>> getJoinClubs() async {
    // try - catch 문 사용해서 통신 예외처리
    Response? response;
    try {
      response = await get(
        "$_apiUrl/users/clubs",
      );
    } catch (e) {
      response = null;
    }

    // 통신 실패
    if (response == null) {
      return {"data": []};
    }

    // 통신 성공
    if (response.statusCode == 200) {
      return response.body;
    } else {
      return {"data": []};
    }
  }
}
