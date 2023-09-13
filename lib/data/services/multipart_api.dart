// ignore_for_file: use_build_context_synchronously, unnecessary_brace_in_string_interps, no_leading_underscores_for_local_identifiers

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:winscart/data/services/urls.dart';
import 'package:winscart/data/shared_preferences/preference_functions.dart';
import 'package:winscart/utils/helpers/helper_loader.dart';
import 'package:winscart/utils/helpers/helper_snackbar.dart';

class MultipartApi {
  static Future<dynamic> upload(BuildContext context,
      {required String endPoint,
      required List<MultipartFile>? files,
      required Map<String, String> body,
      bool isShowMessage = false}) async {
    try {
      loader(context: context);

      var request =
          http.MultipartRequest('POST', Uri.parse('$baseUrl$endPoint'));
      // var file = await http.MultipartFile.fromPath("image", filePath);

      if (files != null) {
        request.files.addAll(files);
      }
      final _headers = {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $userId"
      };
      request.fields.addAll(body);
      request.headers.addAll(_headers);

      debugPrint('$baseUrl$endPoint');
      debugPrint(jsonEncode(request.fields));

      var response = await request.send();
      var responseDecoded = await http.Response.fromStream(response);
      final responseData = json.decode(responseDecoded.body);

      debugPrint("response ${responseDecoded.body}");

      hideLoader(context);

      if ("${responseData}".contains('error')) {
        snackBar(context, message: responseData['error']);
        return;
      }

      if (response.statusCode == 200) {
        snackBar(context,
            message: "Successfully uploaded", type: MessageType.success);
        return responseData;
        // throw response;
      } else {
        throw response.statusCode;
      }
    } on SocketException {
      hideLoader(context);
      snackBar(context,
          message: "No internet connection", type: MessageType.warning);
    } catch (e) {
      hideLoader(context);
      throw Exception("$e");
    }
  }
}
