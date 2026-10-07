part of 'search_bloc.dart';

sealed class SearchEvent {}

final class SearchInitiated extends SearchEvent {
  final String currentUserid;
  final bool isGroupSearch;
  final List<UserModel> selectedUsers;

  SearchInitiated({required this.currentUserid, this.selectedUsers = const [], this.isGroupSearch = false});
}

final class ContactSelectionToggled extends SearchEvent {
  final UserModel selectedUser;

  ContactSelectionToggled({required this.selectedUser});
}

final class SearchInputChanged extends SearchEvent {
  final String searchQuery;

  SearchInputChanged({required this.searchQuery});
}

final class SearchReset extends SearchEvent {}
