import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../models/generate_quiz.dart';

class SharedPreferenceHelper {
  static const String resultsKey = 'quiz_results';

  static Future<void> saveResults(List<Result> results) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> resultsJson = results.map((result) => jsonEncode(result.toJson())).toList();
    await prefs.setStringList(resultsKey, resultsJson);
  }

  static Future<List<Result>> loadResults() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? resultsJson = prefs.getStringList(resultsKey);

    if (resultsJson == null) {
      return [];
    }
    try {
      return resultsJson.map((resultJson) => Result.fromJson(jsonDecode(resultJson))).toList();
    } catch (e) {
      print("Error decoding result JSON: $e");
      return [];
    }
  }
}