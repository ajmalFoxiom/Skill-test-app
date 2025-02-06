import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_app/core/config/config.dart';

import '../../shared/dialog/app_snackbar.dart';
import '../shared_preference/shared_pref.dart';
import 'api_response.dart';
import 'urls.dart';

enum Method { get, post, put, patch, delete }

class Api {
  static Future<ApiResponse> call({
    required String endPoint,
    Method method = Method.get,
    Object? body,
    bool isShowToast = true,
    required Function() onRetryPressed,
  }) async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        "Authorization": accessToken == null ? "" : "Bearer $accessToken",
      };

      final http.Response response;
      Uri url = Uri.parse("$baseUrl/$endPoint");
      debugPrint('$headers');

      if (body != null && method == Method.get) {
        method = Method.post;
      }

      //REST API METHOD
      switch (method) {
        case Method.get:
          response = await http.get(url, headers: headers);
          break;
        case Method.post:
          response =
              await http.post(url, body: json.encode(body), headers: headers);
          break;

        case Method.patch:
          response =
              await http.patch(url, body: json.encode(body), headers: headers);
          break;
        case Method.put:
          response =
              await http.put(url, body: json.encode(body), headers: headers);
          break;

        case Method.delete:
          response = await http.delete(url,
              body: body != null ? json.encode(body) : null, headers: headers);
          break;

        default:
          throw ("Invalid request type");
      }

      if (response.statusCode == 401 && accessToken != null) {
        SharedPref().logout();
        return ApiResponse(success: false, message: "", data: null);
      }

      return ApiResponse.fromJson(url, method, body, response);
    } on SocketException {
      // showToast("Network seems to be offline");

      return ApiResponse(
          success: false, message: "Network seems to be offline", data: null);
    } catch (e) {
      debugPrint(e.toString());
      if (isShowToast) showOverlay(message: e.toString());
      return ApiResponse(success: false, message: e.toString(), data: null);
    }
  }
}
