part of 'search_bloc.dart';

sealed class SearchEvent {}

final class SearchInitiated extends SearchEvent {
  final String currentUserid;
  SearchInitiated({required this.currentUserid});
}

final class ContactSelectionToggled extends SearchEvent {
  final UserModel selectedUser;

  ContactSelectionToggled({required this.selectedUser});
}


