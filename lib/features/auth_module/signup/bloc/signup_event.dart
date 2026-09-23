part of 'signup_bloc.dart';

sealed class SignupEvent {}

class SignupInputFieldChanged extends SignupEvent {
  final String name;
  final String email;
  final String password;
  final String confirmPass;

  SignupInputFieldChanged({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPass,
  });
}
