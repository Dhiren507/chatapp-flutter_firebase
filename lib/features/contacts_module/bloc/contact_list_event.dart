part of 'contact_list_bloc.dart';

sealed class ContactListEvent {}

final class ContactListFetchRequested extends ContactListEvent {}
