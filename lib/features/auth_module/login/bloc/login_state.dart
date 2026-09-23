part of 'login_bloc.dart';

sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class ButtonDisabled extends LoginState {}

final class ButtonEnabled extends LoginState {}
