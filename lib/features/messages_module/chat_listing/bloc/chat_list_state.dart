part of 'chat_list_bloc.dart';

sealed class ChatListState {}

final class ChatListInitial extends ChatListState {}

final class ChatListLoading extends ChatListState {}

final class ChatListLoaded extends ChatListState {
  List<ChatListModel> chatList;
  List<UserStatus> statusList;
  UserStatus? currentUserStatus;

  ChatListLoaded({
    required this.chatList,
    required this.statusList,
    required this.currentUserStatus,
  });
}

final class ChatListError extends ChatListState {
  final String errorMsg;

  ChatListError({required this.errorMsg});
}
