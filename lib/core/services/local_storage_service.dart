import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _tokenKey = 'auth_token';
  static const String _savedUsersKey = 'saved_users';
  static const String _savedMahasiswaKey = 'saved_mahasiswa';

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
  }

  Future<void> addUserToSavedList({
    required String userId,
    required String username,
  }) async {
    await _addToSavedList(
      key: _savedUsersKey,
      userId: userId,
      username: username,
    );
  }

  Future<List<Map<String, String>>> getSavedUsers() async {
    return _getSavedList(_savedUsersKey);
  }

  Future<void> removeSavedUser(String userId) async {
    await _removeFromSavedList(
      key: _savedUsersKey,
      userId: userId,
    );
  }

  Future<void> clearSavedUsers() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_savedUsersKey);
  }

  Future<void> addMahasiswaToSavedList({
    required String userId,
    required String username,
  }) async {
    await _addToSavedList(
      key: _savedMahasiswaKey,
      userId: userId,
      username: username,
    );
  }

  Future<List<Map<String, String>>> getSavedMahasiswa() async {
    return _getSavedList(_savedMahasiswaKey);
  }

  Future<void> removeSavedMahasiswa(String userId) async {
    await _removeFromSavedList(
      key: _savedMahasiswaKey,
      userId: userId,
    );
  }

  Future<void> clearSavedMahasiswa() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_savedMahasiswaKey);
  }

  Future<void> _addToSavedList({
    required String key,
    required String userId,
    required String username,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(key) ?? [];

    final isDuplicate = rawList.any((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'].toString() == userId;
    });

    if (isDuplicate) return;

    final newUser = jsonEncode({
      'user_id': userId,
      'username': username,
      'saved_at': DateTime.now().toIso8601String(),
    });

    rawList.add(newUser);
    await prefs.setStringList(key, rawList);
  }

  Future<List<Map<String, String>>> _getSavedList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(key) ?? [];

    return rawList.map((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;

      return {
        'user_id': (map['user_id'] ?? '').toString(),
        'username': (map['username'] ?? '').toString(),
        'saved_at': (map['saved_at'] ?? '').toString(),
      };
    }).toList();
  }

  Future<void> _removeFromSavedList({
    required String key,
    required String userId,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    final rawList = prefs.getStringList(key) ?? [];

    rawList.removeWhere((item) {
      final map = jsonDecode(item) as Map<String, dynamic>;
      return map['user_id'].toString() == userId;
    });

    await prefs.setStringList(key, rawList);
  }
}