class UserRepository {
  final String userId;
  final String email;
  final String password;

  UserRepository({required this.userId, required this.email, required this.password});

  factory UserRepository.fromJson(Map<String, dynamic> json) {
    return UserRepository(
      userId: json['userId'],
      email: json['email'],
      password: json['password'],
    );
  }
  
}