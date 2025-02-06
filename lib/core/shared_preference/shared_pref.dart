import 'dart:convert';


import 'package:shared_preferences/shared_preferences.dart';

import '../../app/presentation/auth/login_view.dart';
import '../../shared/dialog/app_snackbar.dart';
import '../config/config.dart';
import '../navigators/page_navigator.dart';

class SharedPref {
  SharedPreferences? sharedPref;

  Future<SharedPreferences> get _instance async =>
      sharedPref ??= await SharedPreferences.getInstance();

  Future<SharedPreferences> init() async {
    sharedPref = await _instance;
    return sharedPref!;
  }

  Future<bool> save({required String key, required dynamic value}) async {
    if (sharedPref == null) await init();
    switch (value.runtimeType) {
      case const (String):
        return await sharedPref!.setString(key, value);
      case const (bool):
        return await sharedPref!.setBool(key, value);
      case const (int):
        return await sharedPref!.setInt(key, value);
      case const (double):
        return await sharedPref!.setDouble(key, value);
      default:
        return await sharedPref!.setString(key, jsonEncode(value));
    }
  }

  Future<String?> getUserToken() async {
    if (sharedPref == null) await init();
    accessToken = sharedPref?.getString("token");
    return accessToken;
  }

  logout() async {
    if (sharedPref == null) await init();
    sharedPref!.clear();
    accessToken = null;
    Screen.openAsNewPage(const LoginView());
    showOverlay(
      message: "Logged out successfully",
    );
  }
}
