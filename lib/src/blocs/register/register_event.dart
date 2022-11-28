// ignore_for_file: public_member_api_docs, sort_constructors_first, annotate_overrides
part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {
  get email => null;
}

class RegisterUser extends RegisterEvent {
  final String username;
  final String email;
  final String password;
  RegisterUser({
    required this.username,
    required this.email,
    required this.password,
  });
}
