import 'dart:async';

import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:shared_preferences/shared_preferences.dart';

// This class is used to manage shared preferences for the application.
class SharedPreferencesManager extends ChangeNotifier {
  // Static instance of SharedPreferences
  static late SharedPreferences _sharedPrefs;

  /// Initializes the shared preferences instance.
  /// If it's the first run of the application, it sets the 'first_run' flag to false
  /// and deletes any existing user token.
  Future init() async {
    _sharedPrefs = await SharedPreferences.getInstance();
    if (_sharedPrefs.getBool('first_run') ?? true) {
      await _sharedPrefs.setBool('first_run', false);
    }
  }
}
