abstract class LoginState {}

class LoginInit extends LoginState {}

class Error extends LoginState {
  final String message;

  Error({required this.message});
}

class Loading extends LoginState {}

class LoginSuccess extends LoginState {}

class SignUpSuccess extends LoginState {}

class ResetMailSendSuccess extends LoginState {}
