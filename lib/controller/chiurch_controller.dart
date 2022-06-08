import 'dart:convert';

import 'package:echurch/models/Church.dart';
import 'package:echurch/models/Preaching.dart';
import 'package:echurch/services/api_constant.dart';
import 'package:http/http.dart' as http;
import 'package:echurch/services/api_response.dart';

Future<ApiResponse> getChurch() async {
  ApiResponse apiResponse = ApiResponse();
  try {
    final response = await http
        .get(Uri.parse(churchURL), headers: {'Accept': 'application/json'});

    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => Church.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
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
    final response = await http.get(Uri.parse(preachinghURL + id.toString()),
        headers: {'Accept': 'application/json'});
    switch (response.statusCode) {
      case 200:
        apiResponse.data = jsonDecode(response.body)['data']
            .map((p) => Preaching.fromJson(p))
            .toList();
        apiResponse.data as List<dynamic>;
        print(jsonDecode(response.body));
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
