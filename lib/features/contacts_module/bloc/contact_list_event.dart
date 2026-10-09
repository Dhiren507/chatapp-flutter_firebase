part of 'contact_list_bloc.dart';

sealed class ContactListEvent {}

final class ContactListFetchRequested extends ContactListEvent {
    final String currentUserId;

    ContactListFetchRequested({required this.currentUserId});
}
