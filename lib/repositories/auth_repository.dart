import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

abstract class IAuthenticationRepository {
  Future<bool> login({required String email, required String password});
  Future<void> logout();
}

class AuthenticationRepository extends IAuthenticationRepository{
  @override
  Future<bool> login({required String email, required String password}) async {
    // Đọc tệp JSON từ thư mục assets
    final String response = await rootBundle.loadString('assets/mock/mock_users.json');
    final List<dynamic> data = json.decode(response);

    // Kiểm tra email và mật khẩu
    for (var user in data) {
      if (user['email'] == email && user['password'] == password) {
        return true;
      }
    }
    return false;
  }

  @override
  Future<void> logout() async {
    // Giả lập thời gian trễ mạng
    await Future.delayed(Duration(seconds: 1));
  }
}
