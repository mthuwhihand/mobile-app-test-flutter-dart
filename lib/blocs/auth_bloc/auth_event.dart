import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class AuthLoginEmailChangedEvent extends AuthEvent {
  final String email;

  const AuthLoginEmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class AuthLoginPasswordChangedEvent extends AuthEvent {
  final String password;

  const AuthLoginPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

class AuthLoginSubmittedEvent extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginSubmittedEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class AuthLogoutRequestedEvent extends AuthEvent {
  const AuthLogoutRequestedEvent();

  @override
  List<Object> get props => [];
}