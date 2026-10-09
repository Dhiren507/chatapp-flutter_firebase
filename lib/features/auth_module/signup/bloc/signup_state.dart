part of 'signup_bloc.dart';

enum SignupStatus { initial, loading, success, error }

enum ButtonStatus { initial, disabled, enabled }

final class SignupState {
  final SignupStatus status;
  final ButtonStatus buttonStatus;
  final String errorMsg;

  const SignupState({this.status = .initial, this.buttonStatus = .disabled, this.errorMsg = ''});

  SignupState copyWith({SignupStatus? status, ButtonStatus? buttonStatus, String? errorMsg}) {
    return SignupState(
      status: status ?? this.status,
      buttonStatus: buttonStatus ?? this.buttonStatus,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
