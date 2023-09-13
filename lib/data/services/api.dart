// ignore_for_file: no_leading_underscores_for_local_identifiers, unnecessary_brace_in_string_interps

import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:winscart/data/services/urls.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/utils/helpers/helper_loader.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';

import 'api_response.dart';

enum Method { get, post, put, delete }

class Api {
  static Future<ApiResponse> call(BuildContext context,
      {required String endPoint, required Method method, Object? body}) async {
    try {
      final http.Response response;
      final _headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${userId}"
      };

      debugPrint('$_headers');

      //REST API METHOD
      switch (method) {
        case Method.get:
          String url = baseUrl + endPoint;
          response = await http.get(Uri.parse(url), headers: _headers);
          log("${baseUrl + endPoint} ($method)\n$body");
          log(response.body);
          return ApiResponse.fromJson(response.statusCode, response.body);

        case Method.post:
          response = await http.post(Uri.parse(baseUrl + endPoint),
              body: json.encode(body), headers: _headers);
          log("${baseUrl + endPoint} ($method)\n$body");
          log(response.body);
          return ApiResponse.fromJson(response.statusCode, response.body);

        case Method.put:
          response = await http.put(Uri.parse(baseUrl + endPoint),
              body: json.encode(body), headers: _headers);
          log("${baseUrl + endPoint} ($method)\n$body");
          log(response.body);
          return ApiResponse.fromJson(response.statusCode, response.body);
        case Method.delete:
          response = await http.delete(Uri.parse(baseUrl + endPoint),
              body: json.encode(body), headers: _headers);
          log("${baseUrl + endPoint} ($method)\n$body");
          log(response.body);
          return ApiResponse.fromJson(response.statusCode, response.body);

        default:
          return throw "INVALID METHOD";
      }
    } on SocketException {
      log("${baseUrl + endPoint} ($method)\n$body");
      hideLoader(context);
      snackBar(context, message: "Network seems to be offline");
      return ApiResponse.fromJson(
          500, "{message:'Network seems to be offline'}");
    } catch (e) {
      log("${baseUrl + endPoint} ($method) ${body != null ? '\n$body' : ''}");
      hideLoader(context);
      // snackBar(context, message: e.toString());
      debugPrint("$e");
      return ApiResponse.fromJson(500, "{message:'$e'}");
    }
  }
}
