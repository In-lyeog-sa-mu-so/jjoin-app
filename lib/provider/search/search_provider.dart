import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class SearchProvider extends GetConnect {
  static final String _apiUrl = dotenv.env['JJOIN_API_SERVER_URL']!;

  Future<Map<String, dynamic>> getAllTags() async {
    Response? response;
    try {
      response = await get(
        "$_apiUrl/search/tags",
        query: {"page": "0", "size": "5"},
      );
    } catch (e) {
      print('Error fetching tags: $e');
      return {"data": []}; // 에러 발생 시 빈 데이터를 반환
    }

    if (response?.statusCode == 200) {
      try {
        var decodedBody = json.decode(response.bodyString ?? '');
        if (decodedBody is Map<String, dynamic>) {
          return decodedBody;
        } else {
          return {"data": []}; // JSON 응답이 Map이 아닌 경우 빈 데이터를 반환
        }
      } catch (e) {
        print('Error parsing tags response: $e');
        return {"data": []}; // JSON 파싱 에러 시 빈 데이터를 반환
      }
    } else {
      return {"data": []}; // HTTP 상태 코드가 200이 아닌 경우 빈 데이터를 반환
    }
  }

  Future<Map<String, dynamic>> searchClubsByQuery(
      String searchQuery, List<String> tags) async {
    Response? response;
    try {
      response = await get(
        "$_apiUrl/search",
        query: {
          "keyword": searchQuery,
          if (tags.isNotEmpty) "tags": tags else "tags": [""],
          "page": "0",
          "size": "10",
        },
      );
    } catch (e) {
      return {"clubs": []};
    }

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.bodyString ?? '');
      if (jsonData is Map<String, dynamic> && jsonData["clubs"] != null) {
        return jsonData;
      } else {
        return {"clubs": []};
      }
    } else {
      return {"clubs": []};
    }
  }

  Future<Map<String, dynamic>> getAllClubs() async {
    Response? response;
    try {
      response = await get(
        "$_apiUrl/search",
        query: {
          "keyword": "",
          "tags": [""],
          "page": "0",
          "size": "10",
        },
      );
    } catch (e) {
      return {"clubs": []};
    }

    if (response.statusCode == 200) {
      var jsonData = json.decode(response.bodyString ?? '');
      if (jsonData is Map<String, dynamic> && jsonData["clubs"] != null) {
        return jsonData;
      } else {
        return {"clubs": []};
      }
    } else {
      return {"clubs": []};
    }
  }
}
