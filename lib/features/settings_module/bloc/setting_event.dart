part of 'setting_bloc.dart';

sealed class SettingEvent {}

final class SettingProfileFetchRequested extends SettingEvent {
  final String currentUserId;

  SettingProfileFetchRequested({required this.currentUserId});
}
