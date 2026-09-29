part of 'contact_list_bloc.dart';

sealed class ContactListState {}

final class ContactListInitial extends ContactListState {}

final class ContactListLoading extends ContactListState {}

final class ContactListLoaded extends ContactListState {
  final List<UserModel> contacts;

  ContactListLoaded({required this.contacts});
}

final class ContactListError extends ContactListState {
  final String errorMsg;

  ContactListError({required this.errorMsg});
}
