part of 'login_bloc.dart';

enum LoginStatus { initial, loading, success, error }

enum ButtonStatus { disabled, enabled }

final class LoginState {
  final LoginStatus status;
  final ButtonStatus buttonStatus;
  final String errorMsg;

  const LoginState({this.status = .initial, this.buttonStatus = .disabled, this.errorMsg = ''});

  LoginState copyWith({LoginStatus? status, ButtonStatus? buttonStatus, String? errorMsg}) {
    return LoginState(
      status: status ?? this.status,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
