// shared_preferences_util.dart
import 'package:shared_preferences/shared_preferences.dart';


class SharedPreferencesDatabase {
  static SharedPreferences? _prefs;

  static Future<SharedPreferences> getInstance() async {
    if (_prefs == null) {
      _prefs = await SharedPreferences.getInstance();
    }
    return _prefs!;
  }

  // Add this method to initialize the SharedPreferences instance
  static void initialize(SharedPreferences prefs) {
    _prefs = prefs;
  }

  static Future<void> saveVariable(String key, dynamic value) async {
    final prefs = await getInstance();
    if (value is int) {
      prefs.setInt(key, value);
    } else if (value is double) {
      prefs.setDouble(key, value);
    } else if (value is String) {
      prefs.setString(key, value);
    } else if (value is bool) {
      prefs.setBool(key, value);
    } else {
      throw ArgumentError("Unsupported data type");
    }
  }

  static Future<dynamic> loadVariable(String key, dynamic defaultValue) async {
    final prefs = await getInstance();
    if (defaultValue is int) {
      return prefs.getInt(key) ?? defaultValue;
    } else if (defaultValue is double) {
      return prefs.getDouble(key) ?? defaultValue;
    } else if (defaultValue is String) {
      return prefs.getString(key) ?? defaultValue;
    } else if (defaultValue is bool) {
      return prefs.getBool(key) ?? defaultValue;
    } else {
      throw ArgumentError("Unsupported data type");
    }
  }
}
