import 'package:equatable/equatable.dart';

sealed class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInProgress extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure(this.error);

  @override
  List<Object> get props => [error];
}

class LoginFailureInvalidEmail extends LoginFailure {
  const LoginFailureInvalidEmail() : super('Email must be in the correct email format.');
}

class LoginFailureInvalidPassword extends LoginFailure {
  const LoginFailureInvalidPassword() : super('Passwords must be at least 6 characters long, '
      'contain at least 1 digit, 1 lowercase letter, and 1 uppercase letter');
}
