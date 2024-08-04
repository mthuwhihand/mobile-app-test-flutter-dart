import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/user_model.dart';

class DataService {
  Future<List<UserModel>> loadMockUsers() async {
    final String response = await rootBundle.loadString('assets/mock/mock_users.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => UserModel.fromJson(json)).toList();
  }
}