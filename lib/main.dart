import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'repositories/auth_repository.dart';
import 'views/screens//login_view.dart';
import 'views/screens/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo AuthRepository
  final authRepository = AuthRepository();

  // Kiểm tra trạng thái đăng nhập
  final isLoggedIn = await authRepository.isLoggedIn();

  runApp(
    MyApp(isLoggedIn: isLoggedIn, authRepository: authRepository),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final AuthRepository authRepository;

  MyApp({required this.isLoggedIn, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: authRepository),
      child: MaterialApp(
        title: 'Test App',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: isLoggedIn ? const HomeView() : LoginView(),
        routes: {
          '/login': (context) => LoginView(),
          '/home': (context) => const HomeView(),
        },
      ),
    );
  }
}
