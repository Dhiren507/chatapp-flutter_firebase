part of 'status_bloc.dart';

sealed class StatusEvent {}

final class StatusPostPressed extends StatusEvent {
  String userId;
  String statusImagePath;
  String statusCaption;

  StatusPostPressed({
    required this.userId,
    required this.statusImagePath,
    required this.statusCaption,
  });
}
