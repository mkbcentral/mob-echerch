import 'dart:convert';

import 'package:echurch/controller/user_controller.dart';
import 'package:echurch/models/Church.dart';
import 'package:echurch/models/ChurchEvent.dart';
import 'package:echurch/models/Preaching.dart';
import 'package:echurch/services/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:echurch/services/api_response.dart';

Future<ApiResponse> getChurch() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(churchURL), headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => Church.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
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

Future<ApiResponse> getPreaching(int id) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(preachinghURL + id.toString()),
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => Preaching.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = response.statusCode.toString();
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }

  return apiResponse;
}

Future<ApiResponse> getEvents() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.get(Uri.parse(eventsURL), headers: {
      'Accept': 'application/json',
      'Authorization': "Bearer $token"
    });
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => ChurchEvent.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;

        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = someThingWentWorng;
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }

  return apiResponse;
}

Future<ApiResponse> likeAndDislikeEvent(int eventId) async {
  ApiResponse apiResponse = ApiResponse();
  try {
    String token = await getToken();
    final response = await http.post(Uri.parse("$likeEventURL$eventId/like"),
        headers: {
          'Accept': 'application/json',
          'Authorization': "Bearer $token"
        });

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['message'];
        apiResponse.status = jsonDecode(response.body)['status'];
        break;
      case 401:
        apiResponse.error = unauthorized;
        break;
      default:
        apiResponse.error = jsonDecode(response.body)['message'];
        break;
    }
  } catch (e) {
    apiResponse.error = e.toString();
  }

  return apiResponse;
}
