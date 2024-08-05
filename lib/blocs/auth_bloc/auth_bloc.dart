import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';
import 'login_event.dart';
import 'login_state.dart';
import '../../utils/validators.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authenticationRepository;
  bool hasInvalidEmailError = false;
  bool hasInvalidPasswordError = false;

  LoginBloc({required this.authenticationRepository}) : super(LoginInitial()) {
    on<LoginEmailChangedEvent>(_onLoginEmailChanged);
    on<LoginPasswordChangedEvent>(_onLoginPasswordChanged);
    on<LoginSubmittedEvent>(_onLoginSubmittedEvent);
  }

  void _onLoginEmailChanged(LoginEmailChangedEvent event, Emitter<LoginState> emit) {
    if (hasInvalidEmailError) {
      if (!Validators.isValidEmail(event.email)) {
        emit(LoginFailureInvalidEmail());
      } else {
        hasInvalidEmailError = false;
        emit(LoginInitial());
      }
    }
  }

  void _onLoginPasswordChanged(LoginPasswordChangedEvent event, Emitter<LoginState> emit) {
    if (hasInvalidPasswordError) {
      if (!Validators.isValidPassword(event.password)) {
        emit(LoginFailureInvalidPassword());
      } else {
        hasInvalidPasswordError = false;
        emit(LoginInitial());
      }
    }
  }

  void _onLoginSubmittedEvent(LoginSubmittedEvent event, Emitter<LoginState> emit) async {
    emit(LoginInProgress());

    // Delay for 2 seconds before proceeding
    await Future.delayed(Duration(seconds: 2));

    // Validate email và password trước khi gọi authenticationRepository
    if (!Validators.isValidEmail(event.email)) {
      hasInvalidEmailError = true;
      emit(LoginFailureInvalidEmail());
      return;
    }

    if (!Validators.isValidPassword(event.password)) {
      hasInvalidPasswordError = true;
      emit(LoginFailureInvalidPassword());
      return;
    }

    try {
      final success = await authenticationRepository.login(email: event.email, password: event.password);
      if (success) {
        emit(LoginSuccess());
      } else {
        emit(LoginFailure('Invalid email or password'));
      }
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }
}
