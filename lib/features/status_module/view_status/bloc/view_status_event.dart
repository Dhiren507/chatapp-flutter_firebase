part of 'view_status_bloc.dart';

sealed class ViewStatusEvent {}

final class MarkStatusAsSeen extends ViewStatusEvent {
  final String statusId;
  final String currentUserId;

  MarkStatusAsSeen({required this.statusId, required this.currentUserId});
}

final class StatusIndexChanged extends ViewStatusEvent {
  final int index;

  StatusIndexChanged({required this.index});
}

final class DeleteStatus extends ViewStatusEvent {
  final String statusId;

  DeleteStatus({required this.statusId});
}

final class FetchStatusViewers extends ViewStatusEvent {
  final List<String> viewerIds;

  FetchStatusViewers({required this.viewerIds});
}
