part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, error }

enum ButtonStatus { initial, disabled, enabled }

final class LoginState {
  final LoginStatus status;
  final ButtonStatus buttonStatus;
  final String errorMsg;

  const LoginState({
    this.status = .initial,
    this.buttonStatus = .disabled,
    this.errorMsg = '',
  });

  LoginState copyWith({
    LoginStatus? status,
    ButtonStatus? buttonStatus,
    String? errorMsg,
  }) {
    return LoginState(
      status: status ?? this.status,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}

final class LoginInitial extends LoginState {}

final class LoginLoading extends LoginState {}

final class LoginSuccess extends LoginState {}

final class LoginError extends LoginState {
  final String message;

  LoginError({required this.message});
}

final class ButtonDisabled extends LoginState {}

final class ButtonEnabled extends LoginState {}
