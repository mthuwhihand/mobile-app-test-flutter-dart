import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';

abstract class IAuthRepository {
  Future<bool> login({required String email, required String password});
  Future<void> logout();
  Future<bool> isLoggedIn();
}

class AuthRepository extends IAuthRepository {
  static const _loggedInEmailKey = 'test_app_logged_in_email';

  @override
  Future<bool> login({required String email, required String password}) async {
    // Read JSON from assets
    final String response = await rootBundle.loadString('assets/mock/mock_users.json');
    final List<dynamic> data = json.decode(response);

    // Check email and password
    for (var user in data) {
      if (user['email'] == email && user['password'] == password) {
        // Save email using SharedPreferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(_loggedInEmailKey, email);
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> logout() async {
    // Remove saved email
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_loggedInEmailKey);
  }

  @override
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_loggedInEmailKey);
    return email != null && email.isNotEmpty;
  }
}
