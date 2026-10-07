part of 'search_bloc.dart';

enum SearchStatus { initial, loading, loaded, error }

final class SearchState {
  final SearchStatus status;
  final List<UserModel> contacts;
  final List<UserModel> allFetchedContacts;

  final List<UserChatModel> allChatList;
  final List<UserChatModel> filteredChatList;

  final List<UserModel> selectedUsers;
  final String errorMsg;
  final bool isGroup;

  SearchState({
    this.status = .initial,
    this.contacts = const [],
    this.selectedUsers = const [],
    this.allFetchedContacts = const [],
    this.allChatList = const [],
    this.filteredChatList = const [],
    this.errorMsg = '',
    this.isGroup = false,
  });

  SearchState copyWith({
    SearchStatus? status,
    List<UserModel>? contacts,
    List<UserModel>? selectedUsers,
    List<UserModel>? allFetchedContacts,
    List<UserChatModel>? allChatList,
    List<UserChatModel>? filteredChatList,
    String? errorMsg,
    bool? isGroup,
  }) {
    return SearchState(
      status: status ?? this.status,
      contacts: contacts ?? this.contacts,
      selectedUsers: selectedUsers ?? this.selectedUsers,
      errorMsg: errorMsg ?? this.errorMsg,
      allFetchedContacts: allFetchedContacts ?? this.allFetchedContacts,
      allChatList: allChatList ?? this.allChatList,
      filteredChatList: filteredChatList ?? this.filteredChatList,
      isGroup: isGroup ?? this.isGroup,
    );
  }
}
