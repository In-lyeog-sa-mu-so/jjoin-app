import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:jjoin/model/profile/profile_user.dart';
import 'package:http/http.dart' as http;

class ProfileProvider {
  static Future<User> getProfile(int id) async {
    final response = await http.get(Uri.parse('/users/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }

  /*
  프로필에 사용할 유저 정보 가져오는 메소드
  * */
  Future<User> getUserInfo(int id) async {
    Response response;
    Dio dio = Dio();
    response = await dio.get('/users/$id');

    try {
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        print('Failed to load profile');
        throw Exception('Failed to load profile');
      }
    } on DioError catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to load profile');
    }
  }

  /**
   * userId에 해당하는 유저가 가입한 동아리 목록을 가져오는 메소드
   */
  Future<List<JoinedClub>> getJoinedClubs(int id) async {
    Response response;
    Dio dio = Dio();
    response = await dio.get('/users/$id/clubs');

    try {
      if (response.statusCode == 200) {
        return response.data['data'];
      } else {
        print('Failed to load joined clubs');
        throw Exception('Failed to load joined clubs');
      }
    } on DioError catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to load joined clubs');
    }
  }

  /**
   * userId에 해당하는 유저의 프로필을 수정하는 메소드
   */
  Future<void> updateProfile(
      int id, String profileImageUuid, String introduction) async {
    Dio dio = Dio();
    try {
      Response response = await dio.put(
        '/users/$id',
        data: {
          "profileImageUuid": profileImageUuid,
          "introduction": introduction
        },
      );
      if (response.statusCode == 200) {
        print('Profile updated successfully');
      } else {
        print('Failed to update profile: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Dio error: $e');
      throw Exception('Failed to update profile');
    }
  }
}
