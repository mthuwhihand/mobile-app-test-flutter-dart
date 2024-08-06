import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../utils/validators.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  bool hasInvalidEmailError = false;// Flag to indicate if there is an invalid email error
  bool hasInvalidPasswordError = false;// Flag to indicate if there is an invalid password error

  AuthBloc({required this.authRepository}) : super(AuthLoginInitial()) {
    on<AuthLoginEmailChangedEvent>(_onAuthLoginEmailChanged);
    on<AuthLoginPasswordChangedEvent>(_onAuthLoginPasswordChanged);
    on<AuthLoginSubmittedEvent>(_onAuthLoginSubmittedEvent);
    on<AuthLogoutRequestedEvent>(_onAuthLogoutRequestedEvent);
  }

  // Handle email change event and emit appropriate states
  void _onAuthLoginEmailChanged(AuthLoginEmailChangedEvent event, Emitter<AuthState> emit) {
    if (hasInvalidEmailError) {
      if (!Validators.isValidEmail(event.email)) {
        emit(const AuthLoginFailureInvalidEmail());
      } else {
        emit(AuthLoginInitial());
      }
    }
  }

  // Handle password change event and emit appropriate states
  void _onAuthLoginPasswordChanged(AuthLoginPasswordChangedEvent event, Emitter<AuthState> emit) {
    if (hasInvalidPasswordError) {
      if (!Validators.isValidPassword(event.password)) {
        emit(const AuthLoginFailureInvalidPassword());
      } else {
        emit(AuthLoginInitial());
      }
    }
  }

  // Handle login submission event and perform authentication
  void _onAuthLoginSubmittedEvent(AuthLoginSubmittedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());// Emit loading state to show loading circle

    // Validate email and password before calling authRepository
    if (!Validators.isValidEmail(event.email)) {
      hasInvalidEmailError = true;
      emit(const AuthLoginFailureInvalidEmail());// Emit failure state for invalid email
      return;
    }

    if (!Validators.isValidPassword(event.password)) {
      hasInvalidPasswordError = true;
      emit(const AuthLoginFailureInvalidPassword());// Emit failure state for invalid password
      return;
    }

    // Delay for 1 seconds before proceeding
    await Future.delayed(const Duration(seconds: 1));
    try {
      final success = await authRepository.login(email: event.email, password: event.password);
      if (success) {
        emit(AuthLoginSuccess());// Emit success state if login is successful
      } else {
        emit(const AuthLoginFailure('Invalid email or password'));// Emit failure state for invalid credentials
      }
    } catch (error) {
      emit(AuthLoginFailure(error.toString()));// Emit failure state if an exception occurs
    }
  }

  // Handle logout request event and perform logout
  void _onAuthLogoutRequestedEvent(AuthLogoutRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoginInProgress());// Emit loading state to show loading circle

    // Delay for 1 seconds before proceeding
    await Future.delayed(const Duration(seconds: 1));

    try {
      await authRepository.logout();
      emit(AuthLogoutSuccess());// Emit success state if logout is successful
    } catch (error) {
      emit(AuthLoginFailure(error.toString()));// Emit an error state if an exception occurs,
      // here we use the same error state with AuthLoginState: Failure
    }
  }
}
