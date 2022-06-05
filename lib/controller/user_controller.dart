import 'dart:convert';

import 'package:echurch/models/user.dart';
import 'package:echurch/services/api_constant.dart';
import 'package:echurch/services/api_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<ApiResponse> loginUser(String email, String password) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(loginURL),
        headers: {'Accept': 'application/json'},
        body: {'email': email, 'password': password});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = someThingWentWorng;
        break;
    }
  } catch (e) {
    apiResponse.error = someThingWentWorng;
  }
  return apiResponse;
}

Future<ApiResponse> registerUser(
    String name, String email, String password, String passwordConfirm) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http.post(Uri.parse(registerURL), headers: {
      'Accept': 'application/json'
    }, body: {
      'name': name,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirm
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 422:
        final errors = jsonDecode(response.body)['errors'];
        apiResponse.error = errors[errors.keys.elementAt(0)][0];
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = someThingWentWorng;
        break;
    }
  } catch (e) {
    apiResponse.error = someThingWentWorng;
  }
  return apiResponse;
}

Future<ApiResponse> getUserDetail() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(
      Uri.parse(userURL),
      headers: {'Accept': 'application/json', 'Authorization': 'Bearer $token'},
    );
    switch (response.statusCode) {
      case 200:
        apiResponse.data = User.fromJson(jsonDecode(response.body));
        break;
      case 403:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
      default:
        apiResponse.error = someThingWentWorng;
        break;
    }
  } catch (e) {
    apiResponse.error = someThingWentWorng;
  }
  return apiResponse;
}

Future<String> getToken() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getString("token") ?? '';
}

Future<int> getUserId() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.getInt("userId") ?? 0;
}

Future<bool> logout() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.remove("token");
}

Future<bool> deleteShowHomePref() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.setBool("showHome", false);
}
