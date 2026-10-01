import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/core/data/repositories/contact_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ContactRepository _contactRepo;

  SearchBloc({required this._contactRepo}) : super(SearchInitial()) {
    on<SearchInitiated>(_onSearchInitiated);
    on<ContactSelectionToggled>(_onContactSelectionToggled);
  }

  Future<void> _onSearchInitiated(
    SearchInitiated event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());
    try {
      final contactList = await _contactRepo.getAllContacts(
        event.currentUserid,
      );

      final List<UserModel> sortedContacts = List.from(contactList)
        ..sort(
          (a, b) => (a.name ?? '').toLowerCase().compareTo(
            (b.name ?? '').toLowerCase(),
          ),
        );

      emit(SearchSuccess(contacts: sortedContacts));
    } catch (e) {
      emit(SearchError(errorMsg: 'Error while fetching Contacts'));
    }
  }

  void _onContactSelectionToggled(
    ContactSelectionToggled event,
    Emitter<SearchState> state,
  ) {
    if (state is SearchSuccess) {
      final currentState = state as SearchSuccess;

      final updatedSelectionList = List<UserModel>.from(
        currentState.selectedUsers,
      );

      if (updatedSelectionList.contains(event.selectedUser)) {
        updatedSelectionList.remove(event.selectedUser);
      } else {
        updatedSelectionList.add(event.selectedUser);
      }

      emit(currentState.copyWith(selectedUsers: updatedSelectionList));
    }
  }
}
