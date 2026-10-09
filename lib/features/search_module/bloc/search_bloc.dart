import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/contacts_module/data/repositories/contact_repository.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final ContactRepository _contactRepo;
  final ChatRepository _chatRepo;

  SearchBloc({required this._contactRepo, required this._chatRepo}) : super(SearchState()) {
    on<SearchInitiated>(_onSearchInitiated);
    on<ContactSelectionToggled>(_onContactSelectionToggled);
    on<SearchInputChanged>(_onSearchInputChanged);
  }

  Future<void> _onSearchInitiated(SearchInitiated event, Emitter<SearchState> emit) async {
    emit(state.copyWith(status: .loading));
    try {
      if (event.isGroupSearch == false) {
        final contactList = await _contactRepo.getAllContacts(event.currentUserid);

        final List<UserModel> sortedContacts = List.from(contactList)
          ..sort((a, b) => (a.name ?? '').toLowerCase().compareTo((b.name ?? '').toLowerCase()));

        emit(
          state.copyWith(
            status: .loaded,
            contacts: sortedContacts,
            selectedUsers: event.selectedUsers,
            allFetchedContacts: sortedContacts,
          ),
        );
      } else {
        final allChatList = await _chatRepo.fetchUserChatList(event.currentUserid);

        final groupChatsOnly = allChatList.where((chat) => chat.isGroup == true).toList();

        emit(
          state.copyWith(
            status: .loaded,
            allChatList: groupChatsOnly,
            filteredChatList: groupChatsOnly,
            isGroup: true,
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: .error, errorMsg: 'Error while fetching Contacts'));
    }
  }

  void _onContactSelectionToggled(ContactSelectionToggled event, Emitter<SearchState> emit) {
    if (state.status == .loaded) {
      final updatedSelectionList = List<UserModel>.from(state.selectedUsers);

      final int existingIndex = updatedSelectionList.indexWhere((user) => user.uid == event.selectedUser.uid);

      if (existingIndex >= 0) {
        updatedSelectionList.removeAt(existingIndex);
      } else {
        updatedSelectionList.add(event.selectedUser);
      }

      print('this is the firest contaact selected : $updatedSelectionList');

      emit(state.copyWith(selectedUsers: updatedSelectionList));
    }
  }

  void _onSearchInputChanged(SearchInputChanged event, Emitter<SearchState> emit) {
    if (state.status == .loaded) {
      if (state.isGroup == true) {
        final loadedChatList = List<UserChatModel>.from(state.allChatList);

        if (event.searchQuery.isEmpty) {
          emit(state.copyWith(filteredChatList: loadedChatList, searchQuery: ''));
          return;
        }

        final filteredGroups = loadedChatList.where((chat) {
          final groupName = chat.groupName?.toLowerCase() ?? '';
          final query = event.searchQuery.toLowerCase();
          return groupName.contains(query);
        }).toList();

        emit(state.copyWith(filteredChatList: filteredGroups, searchQuery: event.searchQuery));
        return;
      }

      final allContactList = List<UserModel>.from(state.allFetchedContacts);

      if (event.searchQuery.trim().isEmpty) {
        emit(state.copyWith(contacts: allContactList, searchQuery: ''));
        return;
      }

      final filteredContactList = allContactList.where((contact) {
        final name = contact.name?.toLowerCase() ?? '';
        final query = event.searchQuery.toLowerCase();
        return name.contains(query);
      }).toList();

      emit(state.copyWith(contacts: filteredContactList, searchQuery: event.searchQuery));
    }
  }
}
