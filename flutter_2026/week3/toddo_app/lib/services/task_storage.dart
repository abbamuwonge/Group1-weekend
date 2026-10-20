import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/tasks.dart';

class TaskStorage {
  static const _key = 'tasks';

  Future<List<Task>> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    final List<dynamic> decoded = jsonDecode(raw);
    return decoded
        .map((e) => Task.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<void> save(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = jsonEncode(tasks.map((e) => e.toJson()).toList());
    await prefs.setString(_key, raw);
  }
}
