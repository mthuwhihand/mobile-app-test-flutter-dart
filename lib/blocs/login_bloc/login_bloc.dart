import 'package:rxdart/rxdart.dart';
import '../services/auth_service.dart';
import '../utils/validators.dart';

class LoginBloc {
  final AuthService _authService = AuthService();

  final _emailController = BehaviorSubject<String>();
  final _passwordController = BehaviorSubject<String>();
  final _loginStatusController = BehaviorSubject<bool>();

  Stream<String> get emailStream => _emailController.stream;
  Stream<String> get passwordStream => _passwordController.stream;
  Stream<bool> get loginStatusStream => _loginStatusController.stream;

  Function(String) get changeEmail => _emailController.sink.add;
  Function(String) get changePassword => _passwordController.sink.add;

  void login() async {
    final email = _emailController.value;
    final password = _passwordController.value;
    if (Validators.isValidEmail(email) && Validators.isValidPassword(password)) {
      final user = await _authService.login(email, password);
      _loginStatusController.sink.add(user != null);
    } else {
      _loginStatusController.sink.add(false);
    }
  }

  void dispose() {
    _emailController.close();
    _passwordController.close();
    _loginStatusController.close();
  }
}
