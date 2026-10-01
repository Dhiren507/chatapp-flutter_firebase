part of 'search_bloc.dart';

sealed class SearchState {}

final class SearchInitial extends SearchState {}

final class SearchLoading extends SearchState {}

final class SearchSuccess extends SearchState {
  final List<UserModel> contacts;
  final List<UserModel> selectedUsers;

  SearchSuccess({required this.contacts, this.selectedUsers = const []});

  SearchSuccess copyWith({
    List<UserModel>? contacts,
    List<UserModel>? selectedUsers,
  }) {
    return SearchSuccess(
      contacts: contacts ?? this.contacts,
      selectedUsers: selectedUsers ?? this.selectedUsers,
    );
  }
}

final class SearchError extends SearchState {
  final String errorMsg;

  SearchError({required this.errorMsg});
}
