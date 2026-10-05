import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/core/data/repositories/contact_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'contact_list_event.dart';

part 'contact_list_state.dart';

class ContactListBloc extends Bloc<ContactListEvent, ContactListState> {
  final ContactRepository _contactRepo;

  ContactListBloc({required this._contactRepo}) : super(ContactListInitial()) {
    on<ContactListFetchRequested>(_onContactListFetchRequested);
  }

  Future<void> _onContactListFetchRequested(
    ContactListFetchRequested event,
    Emitter<ContactListState> emit,
  ) async {
    emit(ContactListLoading());
    try {
      final contactList = await _contactRepo.getAllContacts(
        event.currentUserId,
      );
      print(' this are the fetched raw contact json contacts ${contactList}');

      final List<UserModel> sortedContacts = List.from(contactList)
        ..sort(
          (a, b) => (a.name ?? '').toLowerCase().compareTo(
            (b.name ?? '').toLowerCase(),
          ),
        );

      print(' this are the sorted contacts ${sortedContacts}');

      emit(ContactListLoaded(contacts: sortedContacts));
    } catch (e) {
      emit(ContactListError(errorMsg: e.toString()));
    }
  }
}
