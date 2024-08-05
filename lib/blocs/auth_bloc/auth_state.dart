import 'package:equatable/equatable.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthLoginInitial extends AuthState {}

class AuthLoginInProgress extends AuthState {}

class AuthLoginSuccess extends AuthState {}

class AuthLogoutSuccess extends AuthState {}

class AuthLoginFailure extends AuthState {
  final String error;

  const AuthLoginFailure(this.error);

  @override
  List<Object> get props => [error];
}

class AuthLoginFailureInvalidEmail extends AuthLoginFailure {
  const AuthLoginFailureInvalidEmail() : super('Email must be in the correct email format.');
}

class AuthLoginFailureInvalidPassword extends AuthLoginFailure {
  const AuthLoginFailureInvalidPassword() : super('Passwords must be at least 6 characters long, '
      'contain at least 1 digit, 1 lowercase letter, and 1 uppercase letter');
}
