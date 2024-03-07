part of 'login_bloc.dart';

@immutable
sealed class LoginEvent {}

final class LoginLoadingEvent extends LoginEvent {
  final String email;
  final String password;

  LoginLoadingEvent({required this.email, required this.password});
}

final class RegisterLoadingEvent extends LoginEvent {
  final LoginModel loginModel;

  RegisterLoadingEvent(this.loginModel);
}
