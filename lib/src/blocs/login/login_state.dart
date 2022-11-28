// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

@immutable
abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginIsLoading extends LoginState {}

class LoginIsFailed extends LoginState {
  final String message;
  LoginIsFailed({
    required this.message,
  });
}

class Authenticated extends LoginState {}

class UnAuthenticated extends LoginState {
  final String message;
  UnAuthenticated({
    required this.message,
  });
}

class AuthError extends LoginState {
  final String error;

  AuthError(this.error);
}

class LoginIsSuccess extends LoginState {}
