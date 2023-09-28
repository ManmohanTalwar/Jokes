import 'dart:developer';

import 'package:jokes/injection.dart';
import 'package:streaming_shared_preferences/streaming_shared_preferences.dart';

class AppPrefs {
  final StreamingSharedPreferences preferences;

  AppPrefs(
    this.preferences,
  )   : isNetworkError = preferences.getBool(
          PrefsConstants.isNetworkError,
          defaultValue: false,
        ),
        isFirstOpen = preferences.getBool(
          PrefsConstants.isFirstOpen,
          defaultValue: true,
        ),
        token = preferences.getString(
          PrefsConstants.token,
          defaultValue: '',
        ),
        jokes = preferences.getCustomValue(
          PrefsConstants.jokes,
          defaultValue: {},
          adapter: const JsonAdapter(),
        );

  final Preference<bool> isFirstOpen;
  final Preference<bool> isNetworkError;
  final Preference<String> token;
  Preference<Map<String, dynamic>> jokes;

  Future<bool> setBool(String key, bool value) async {
    printBefore(value: value, key: key);
    return await preferences.setBool(key, value);
  }

  Future<bool> setDouble(String key, double value) async {
    printBefore(value: value, key: key);
    return await preferences.setDouble(key, value);
  }

  Future<bool> setInt(String key, int value) async {
    printBefore(value: value, key: key);
    return await preferences.setInt(key, value);
  }

  Future<void> clear() async {
    await preferences.clear();
    locator.resetLazySingleton<AppPrefs>(
      instance: locator<AppPrefs>(),
    );
    await locator<AppPrefs>().isFirstOpen.setValue(false);
  }

  Future<bool> setString(String key, String value) async {
    printBefore(value: value, key: key);
    return await preferences.setString(key, value);
  }

  Future<bool> setStringList(String key, List<String> value) async {
    printBefore(value: value, key: key);
    return await preferences.setStringList(key, value);
  }

  Future<bool> setCustomValue(
      String key, value, PreferenceAdapter<dynamic> adapter) async {
    printBefore(value: value, key: key);
    return await preferences.setCustomValue(key, value, adapter: adapter);
  }

  void printBefore({String? key, value}) =>
      log('Saving Key: $key &  value: $value');
}

class PrefsConstants {
  static const String isNetworkError = 'isNetworkError';
  static const String isFirstOpen = 'isFirstOpen';
  static const String token = 'token';
  static const String jokes = 'jokes';
}
