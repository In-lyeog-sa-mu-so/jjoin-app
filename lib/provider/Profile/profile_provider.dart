import 'dart:convert';

import 'package:jjoin/model/profile/profile_user.dart';
import 'package:http/http.dart' as http;

class ProfileProvider {
  static Future<User> getProfile(int id) async {
    final response = await http.get(Uri.parse('https://users/$id'));
    if (response.statusCode == 200) {
      return User.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load profile');
    }
  }
}
