part of 'view_status_bloc.dart';

class ViewStatusState {
  final int currentIndex;
  final bool isDeleting;
  final bool isDeleted;
  final bool isLoadingViewers;
  final List<UserModel> viewers;

  const ViewStatusState({
    this.currentIndex = 0,
    this.isDeleting = false,
    this.isDeleted = false,
    this.isLoadingViewers = false,
    this.viewers = const [],
  });

  ViewStatusState copyWith({
    int? currentIndex,
    bool? isDeleting,
    bool? isDeleted,
    bool? isLoadingViewers,
    List<UserModel>? viewers,
  }) {
    return ViewStatusState(
      currentIndex: currentIndex ?? this.currentIndex,
      isDeleting: isDeleting ?? this.isDeleting,
      isDeleted: isDeleted ?? this.isDeleted,
      isLoadingViewers: isLoadingViewers ?? this.isLoadingViewers,
      viewers: viewers ?? this.viewers,
    );
  }
}

final class ViewStatusInitial extends ViewStatusState {
  const ViewStatusInitial() : super();
}
