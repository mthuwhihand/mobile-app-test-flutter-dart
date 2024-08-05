import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../utils/validators.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  bool hasInvalidEmailError = false;
  bool hasInvalidPasswordError = false;

  AuthBloc({required this.authRepository}) : super(AuthLoginInitial()) {
    on<AuthLoginEmailChangedEvent>(_onAuthLoginEmailChanged);
    on<AuthLoginPasswordChangedEvent>(_onAuthLoginPasswordChanged);
    on<AuthLoginSubmittedEvent>(_onAuthLoginSubmittedEvent);
    on<AuthLogoutRequestedEvent>(_onAuthLogoutRequestedEvent);
  }

  void _onAuthLoginEmailChanged(AuthLoginEmailChangedEvent event, Emitter<AuthState> emit) {
    if (hasInvalidEmailError) {
      if (!Validators.isValidEmail(event.email)) {
        emit(const AuthLoginFailureInvalidEmail());
      } else {
        emit(AuthLoginInitial());
      }
    }
  }

  void _onAuthLoginPasswordChanged(AuthLoginPasswordChangedEvent event, Emitter<AuthState> emit) {
    if (hasInvalidPasswordError) {
      if (!Validators.isValidPassword(event.password)) {
        emit(const AuthLoginFailureInvalidPassword());
      } else {
        emit(AuthLoginInitial());
      }
    }
  }

  void _onAuthLoginSubmittedEvent(AuthLoginSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());

    // Validate email và password trước khi gọi authenticationRepository
    if (!Validators.isValidEmail(event.email)) {
      hasInvalidEmailError = true;
      emit(const AuthLoginFailureInvalidEmail());
      return;
    }

    if (!Validators.isValidPassword(event.password)) {
      hasInvalidPasswordError = true;
      emit(const AuthLoginFailureInvalidPassword());
      return;
    }

    // Delay for 2 seconds before proceeding
    await Future.delayed(const Duration(seconds: 2));
    try {
      final success = await authRepository.login(email: event.email, password: event.password);
      if (success) {
        emit(AuthLoginSuccess());
      } else {
        emit(const AuthLoginFailure('Invalid email or password'));
      }
    } catch (error) {
      emit(AuthLoginFailure(error.toString()));
    }
  }
  void _onAuthLogoutRequestedEvent(AuthLogoutRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());

    // Delay for 2 seconds before proceeding
    await Future.delayed(const Duration(seconds: 2));

    try {
      await authRepository.logout();
      emit(AuthLogoutSuccess());
    } catch (error) {
      emit(AuthLoginFailure(error.toString()));
    }
  }
}
