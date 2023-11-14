import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ClubProvider extends GetConnect {
  static final String _apiUrl = dotenv.env['JJOIN_API_SERVER_URL']!;

  /* Common */
  Future<bool> patchSchedule(int scheduleId) async {
    Response? response;
    try {
      response = await patch(
        "$_apiUrl/schedules/1",
        {
          "isAgree": true,
        },
      );
    } catch (e) {
      response = null;
    }

    // 통신 실패
    if (response == null) {
      return false;
    }

    // 통신 성공
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  /* Home */
  Future<Map<String, dynamic>> getJoinClubs() async {
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
      print(response.body);
      return response.body;
    } else {
      return {"data": []};
    }
  }

  Future<Map<String, dynamic>> getUserSchedules() async {
    // try - catch 문 사용해서 통신 예외처리
    Response? response;
    try {
      response = await get(
        "$_apiUrl/users/schedules",
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
      print(response.body);
      return response.body;
    } else {
      return {"data": []};
    }
  }

  Future<Map<String, dynamic>> getUserRecommendClubs() async {
    Response? response;
    try {
      response = await get(
        "$_apiUrl/clubs/recommends",
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

  /* Calendar */
  Future<Map<String, dynamic>> getUserCalendar(
      DateTime startDate, DateTime endDate) async {
    Response? response;
    try {
      response = await get(
        "$_apiUrl/users/schedules",
        query: {
          "startDate": DateFormat('yyyyMMdd').format(startDate),
          "endDate": DateFormat('yyyyMMdd').format(endDate),
        },
      );
    } catch (e) {
      response = null;
    }

    if (response == null) {
      return {"data": []};
    }

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return {"data": []};
    }
  }

  Future<Map<String, dynamic>> getUserSchedulesByDate(DateTime date) async {
    Response? response;
    try {
      response = await get(
        "$_apiUrl/schedules/${DateFormat('yyyyMMdd').format(date)}",
      );
    } catch (e) {
      response = null;
    }

    if (response == null) {
      return {"data": []};
    }

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return {"data": []};
    }
  }
}
