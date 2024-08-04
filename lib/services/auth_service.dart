import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import 'data_service.dart';

class AuthService {
  final DataService _dataService = DataService();

  Future<UserModel?> login(String email, String password) async {
    final users = await _dataService.loadMockUsers();
    for (UserModel user in users) {
      if (user.email == email && user.password == password) {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('isLoggedIn', true);
        prefs.setString('userId', user.userId);
        return user;
      }
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('isLoggedIn');
    prefs.remove('userId');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}
