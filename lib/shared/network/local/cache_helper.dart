import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{
  static SharedPreferences? sharedPreferences;

  static init() async
  {

    SharedPreferences? prefs = await SharedPreferences.getInstance();
  }

  static Future<bool> putBoolData({
    required String key,
    required bool value,
  }) async
  {
    return await sharedPreferences!.setBool(key, value);
  }

  static dynamic getBoolData({
    required String key,
  })
  {
    return sharedPreferences!.getBool(key);
  }

  static Future<dynamic> putStringData({
    required String key,
    required String value,
  })
  {
    return sharedPreferences!.setString(key, value);
  }

  static dynamic getStringData({
    required String key,
  })
  {
    return sharedPreferences!.getString(key);
  }


  static Future<dynamic> saveData({
    required String key,
    required dynamic value,
  }) async
  {
    if(value is String) await sharedPreferences!.setString(key, value);
    if(value is int) await sharedPreferences!.setInt(key, value);
    if(value is bool) await sharedPreferences!.setBool(key, value);
    return await sharedPreferences!.setDouble(key, value);
  }

  static dynamic getData({
    required dynamic key,
  }) async
  {
    return await sharedPreferences!.get(key);
  }
}