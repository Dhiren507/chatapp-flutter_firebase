part of 'view_status_bloc.dart';

sealed class ViewStatusEvent {}

final class MarkStatusAsSeen extends ViewStatusEvent {
  final String statusId;
  final String currentUserId;

  MarkStatusAsSeen({required this.statusId, required this.currentUserId});
}
