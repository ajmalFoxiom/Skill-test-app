import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'api.dart';

class ApiResponse<T> {
  final bool success;
  final String message;
  final dynamic data;

  ApiResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ApiResponse.fromJson(
    Uri url,
    Method method,
    Object? body,
    http.Response? response, {
    String? fetchKeyName = "data",
  }) {
    debugPrint("API Call: $url ($method)");

    if (body != null) {
      log("Request Body: ${jsonEncode(body)}");
    }

    if (response == null) {
      return ApiResponse(
        success: false,
        message: "No response received",
        data: null,
      );
    }

    String message = "";
    dynamic data;

    try {
      final isSuccess =
          response.statusCode == 200 || response.statusCode == 201;
      final responseBody = response.body;

      debugPrint("Status Code: ${response.statusCode}");
      log("Response Body: $responseBody");

      final dynamic decodedResponse = json.decode(responseBody);

      if (decodedResponse is List) {
        data = decodedResponse;
        message = "Success";
      } else if (decodedResponse is Map<String, dynamic>) {
        if (decodedResponse['status'] == false || !isSuccess) {
          message = decodedResponse["message"] ?? "Request failed";
          throw message;
        }

        if (decodedResponse.containsKey(fetchKeyName)) {
          data = decodedResponse[fetchKeyName];
        } else {
          data = decodedResponse;
        }

        message = decodedResponse["message"] ?? "Success";
      } else {
        throw "Invalid response format";
      }

      return ApiResponse(
        data: data,
        success: isSuccess,
        message: message,
      );
    } catch (e) {
      debugPrint("Error parsing response: $e");
      if (message.isEmpty) {
        message = e.toString();
      }
      throw message;
    }
  }

  List<T> asList<T>(T Function(Map<String, dynamic>) fromJson) {
    if (data is List) {
      return (data as List)
          .map((item) => fromJson(item as Map<String, dynamic>))
          .toList();
    }
    return [];
  }

  T? asModel<T>(T Function(Map<String, dynamic>) fromJson) {
    if (data is Map<String, dynamic>) {
      return fromJson(data as Map<String, dynamic>);
    }
    return null;
  }
}
