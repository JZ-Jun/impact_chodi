import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  SharedPreferencesService._privateConstructor();

  static final SharedPreferencesService instance =
      SharedPreferencesService._privateConstructor();

  Future<void> setUserId(int id) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setInt("userId", id).then((value) => {});
  }

  Future<int> getUserId() async {
    final SharedPreferences prefs = await _prefs;
    int res = -1;
    try {
      res = prefs.getInt("userId") as int;
    } catch (e) {
      return res;
    }
    return res;
  }
}
