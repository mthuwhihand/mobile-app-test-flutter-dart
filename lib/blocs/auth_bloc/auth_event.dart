import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailChangedEvent extends LoginEvent {
  final String email;

  const LoginEmailChangedEvent(this.email);

  @override
  List<Object> get props => [email];
}

class LoginPasswordChangedEvent extends LoginEvent {
  final String password;

  const LoginPasswordChangedEvent(this.password);

  @override
  List<Object> get props => [password];
}

class LoginSubmittedEvent extends LoginEvent {
  final String email;
  final String password;

  const LoginSubmittedEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}
