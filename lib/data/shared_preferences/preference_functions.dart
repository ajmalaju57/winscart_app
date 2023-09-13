import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'keys.dart';

/// <b>Save key-value pairs<b/>
/// * SAVE : SharedPref.save("key", "value");
/// * GET VALUES<br/>
/// String username = SharedPref.getString("key");<br>
/// Int username = SharedPref.getInt("key");
/// * CLEAR : SharedPref.clear;

String? userId;
String? currentUserName;

class SharedPref {
  static Future<SharedPreferences> get _instance async =>
      _pref ??= await SharedPreferences.getInstance();
  static SharedPreferences? _pref;

  // call this method from iniState() function of mainApp().
  static Future<SharedPreferences> init() async {
    _pref = await _instance;
    debugPrint("SHARED PREFERENCE INIT");
    return _pref!;
  }

  static Future<bool> save(
      {required String key, required dynamic value}) async {
    // currentUserName = tokenResponse.name;
    if (_pref == null) await init();
    switch (value.runtimeType) {
      case String:
        return _pref!.setString(key, value);
      case bool:
        return _pref!.setBool(key, value);
      case int:
        return _pref!.setInt(key, value);
      case double:
        return _pref!.setDouble(key, value);
      default:
        return _pref!.setString(key, jsonEncode(value));
    }
  }

  static Future<dynamic> getUserInfo() async {
    final pref = await SharedPreferences.getInstance();
    final String? userData = pref.getString(userToken);
    final String? currentUserData = pref.getString(userName);
    if (userData == null) {
      debugPrint(" SHAREF PREF false");

      return null;
    }
    userId = userData;
    currentUserName = currentUserData;
    debugPrint(" SHAREF PREF true  $userId $currentUserName");

    return userId;
  }

  static clear() async {
    final pref = await SharedPreferences.getInstance();
    pref.clear();
  }
}
