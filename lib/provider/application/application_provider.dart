import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ApplicationProvider extends GetConnect {
  static final String _apiUrl = dotenv.env['JJOIN_API_SERVER_URL']!;

  Future<Map<String, dynamic>> getApplicationForm(int clubId) async {
    //ApplicationForm을 /clubs/{clubId}/applications/ 로부터 받아오는
    Response? response;
    try {
      response = await get(
        "$_apiUrl/clubs/$clubId/applications",
      );
    } catch (e) {
      print("시발");
      response = null;
    }
    print("provider: $clubId");
    print(response?.statusCode);
    print(response?.body);

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

  Future<bool> postApplication(int clubId, Map<String, dynamic> data) async {
    Response? response;
    try {
      response = await post(
        "$_apiUrl/clubs/$clubId/applications/",
        data,
      );
    } catch (e) {
      response = null;
    }
    print(data);
    print(response!.statusCode);
    // 통신 실패
    if (response == null) {
      return false;
    }

    // 통신 성공
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
