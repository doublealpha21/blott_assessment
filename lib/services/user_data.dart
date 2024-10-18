import 'package:shared_preferences/shared_preferences.dart';

class UserDataManager {
  static const String _keyFirstName = 'firstName';

  static Future<void> saveFirstName(String firstName) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFirstName, firstName);
  }

  static Future<String?> getFirstName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFirstName);
  }
}
