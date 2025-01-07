import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SessionHelper {
  static const _loginTimeKey = 'loginTime';
  static const sessionDuration = Duration(minutes: 2);

  // Lưu thời điểm đăng nhập
  static Future<void> saveLoginTime() async {
    final prefs = await SharedPreferences.getInstance();
    final loginTime = DateTime.now().millisecondsSinceEpoch;
    print('Saving login time: $loginTime');
    prefs.setInt(_loginTimeKey, loginTime);
  }

  // Kiểm tra session còn hiệu lực không
  static Future<bool> isSessionValid() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final loginTime = prefs.getInt(_loginTimeKey);
      print('Checking session. Login time: $loginTime');
      // final loginTime = await SharedPreferences.getInstance().then(
      //       (prefs) => prefs.getInt(_loginTimeKey) ?? 0,
      // );
      if (loginTime == null) return false;

      final now = DateTime.now().millisecondsSinceEpoch;
      return now - loginTime < sessionDuration.inMilliseconds;
    } catch (e) {
      print('Error in isSessionValid: $e');
      return false;
    }
  }

  // Xóa session
  static Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove(_loginTimeKey);
  }
}
