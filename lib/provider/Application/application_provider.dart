import 'package:jjoin/model/Application/application_question.dart';
import 'package:dio/dio.dart';

class ApplicationProvider {
  static Future<void> postAnswer(
      int clubId, int applicationId, Map<int, String> answers) async {
    Dio dio = Dio();
    try {
      Response response = await dio.post(
        '/clubs/$clubId/applications/$applicationId',
        data: {'answers': answers},
      );
      // Handle response
      print('Success: ${response.data}');
    } on DioError catch (e) {
      // Handle error
      print('DioError: $e');
    }
  }
}
