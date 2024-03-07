part of 'login_bloc.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {
  final UserCredential userCredential;

  LoginSuccess({required this.userCredential});
}

final class LoginError extends LoginState {
  final String message;
  LoginError({required this.message});
}

final class RegisterInitial extends LoginState {}
final class RegisterLoading extends LoginState {}

final class RegisterSuccess extends LoginState {}

final class RegisterError extends LoginState {
  final String message;

  RegisterError({required this.message});
}
