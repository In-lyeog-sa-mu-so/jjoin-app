import 'dart:async';
import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';

class ProfileProvider extends GetConnect {
  static final String _apiUrl = dotenv.env['JJOIN_API_SERVER_URL']!;

  Future<Map<String, dynamic>> getUserInfo() async {
    Response? response;
    try {
      response = await get(
        "$_apiUrl/users/1",
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

  Future<Map<String, dynamic>> getJoinClubs() async {
    Response? response;
    try {
      response = await get(
        "$_apiUrl/users/1/clubs",
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
      //print(response.body);
      return response.body;
    } else {
      return {"data": []};
    }
  }

  Future<bool> putUserProfileImage(
      dynamic uploadImage, String introduction) async {
    Response? response;
    final extractType = extractExt(uploadImage.path);
    String jsonIntroduction = jsonEncode(introduction);

    final FormData formData = FormData({
      "userProfileImageFile": MultipartFile(uploadImage,
          filename: "profile.png",
          contentType:
              'image/$extractType'), // Use the correct filename and contentType as per the image file
      "data": MultipartFile(utf8.encode(jsonIntroduction),
          filename: "data.json",
          contentType:
              'application/json'), // Use the correct filename and contentType as per the image file
    });

    try {
      response = await put(
        "$_apiUrl/users/1",
        formData,
      );
    } catch (e) {
      if (response != null) {
        //print(response.statusCode);
        //print(response.body);
      }
      return false;
    }

// Response handling
    if (response.statusCode == 200) {
      //print("Request successful.");
      // You can return an empty map or a success message as per your application's needs
      return true;
    } else {
      //print("Request failed with status code: ${response.statusCode}");
      return false;
    }
  }

  String extractExt(String originalFilename) {
    int pos = originalFilename.lastIndexOf(".");
    return originalFilename.substring(pos + 1);
  }
}
