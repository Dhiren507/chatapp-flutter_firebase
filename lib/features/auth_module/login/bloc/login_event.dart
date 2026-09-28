part of 'login_bloc.dart';

sealed class LoginEvent {}

class LoginInputFieldChanged extends LoginEvent {
  final String email;
  final String password;

  LoginInputFieldChanged({required this.email, required this.password});
}

class LoginRequested extends LoginEvent {
  final String email;
  final String password;

  LoginRequested({required this.email, required this.password});
}


class LoginWithGoogleRequested extends LoginEvent {
}