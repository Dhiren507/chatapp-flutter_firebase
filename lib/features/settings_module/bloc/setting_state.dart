part of 'setting_bloc.dart';

enum SettingStatus { initial, loading, loaded, error }

final class SettingState {
  final SettingStatus status;
  final UserModel? userProfile;
  final String errorMsg;

  const SettingState({
    this.status = SettingStatus.initial,
    this.userProfile,
    this.errorMsg = '',
  });

  SettingState copyWith({
    SettingStatus? status,
    UserModel? userProfile,
    String? errorMsg,
  }) {
    return SettingState(
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
