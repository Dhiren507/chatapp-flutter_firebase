part of 'search_bloc.dart';

sealed class SearchEvent {}

final class SearchInitiated extends SearchEvent {
  final String currentUserid;
  final List<UserModel> selectedUsers;
  SearchInitiated({required this.currentUserid, required this.selectedUsers});
}

final class ContactSelectionToggled extends SearchEvent {
  final UserModel selectedUser;

  ContactSelectionToggled({required this.selectedUser});
}


