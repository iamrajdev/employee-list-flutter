import 'package:shared_preferences/shared_preferences.dart';

setString(String key, var value) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString(key, value.toString());
}

Future<String> getString(String key) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString(key) ?? '';
}

String getInitialsWord(String fullName) => fullName.isNotEmpty
    ? fullName.trim().split(RegExp(' +')).map((s) => s[0]).take(2).join()
    : '';
