import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    String returnValue = (prefs.getString(key));
    return returnValue;
  }

  save(String key, value) async {
    final prefs = await SharedPreferences.getInstance();
    String val = json.encode(value);
    prefs.setString(key, val);
  }

  remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(key);
  }
}
