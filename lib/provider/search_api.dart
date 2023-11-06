import 'dart:convert';

import 'package:jjoin/model/search_club.dart';
import 'package:http/http.dart' as http;

class ApiSearch {

  //엔드포인트의 searchclub response body 를 가져오는 함수
  Future<List<SearchClub>> getClubs() async {
    List<SearchClub> clubInstances = [];
    final response = await http.get(
      Uri.parse(
          'https://search'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> clubs = jsonDecode(response.body);
      for (var club in clubs) {
        clubInstances.add(SearchClub.fromJson(club));
      }
      return clubInstances;
    }
    else {
      throw Exception('Failed to load clubs');
    }
    }

  }



