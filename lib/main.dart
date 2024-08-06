import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth_bloc/auth_bloc.dart';
import 'repositories/auth_repository.dart';
import 'views/screens//login_view.dart';
import 'views/screens/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize AuthRepository
  final authRepository = AuthRepository();

  // Check isLoggedIn
  final isLoggedIn = await authRepository.isLoggedIn();

  runApp(
    MyApp(isLoggedIn: isLoggedIn, authRepository: authRepository),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final AuthRepository authRepository;

  const MyApp({super.key, required this.isLoggedIn, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: authRepository),
      child: MaterialApp(
        title: 'Test App',
        theme: ThemeData.dark().copyWith(
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            color: Colors.black54,
          ),
          scaffoldBackgroundColor: Colors.black54,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white12,
            labelStyle: TextStyle(color: Colors.white),
            hintStyle: TextStyle(color: Colors.white70),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white54),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            border: OutlineInputBorder(),
          ),
        ),
        home: isLoggedIn ? const HomeView() : const LoginView(),
        routes: {
          '/login': (context) => const LoginView(),
          '/home': (context) => const HomeView(),
        },
      ),
    );
  }
}
