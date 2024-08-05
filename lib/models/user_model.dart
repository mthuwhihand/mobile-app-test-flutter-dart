class UserModel {
  final String userId;
  final String email;
  final String password;

  UserModel({required this.userId, required this.email, required this.password});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      email: json['email'],
      password: json['password'],
    );
  }

}