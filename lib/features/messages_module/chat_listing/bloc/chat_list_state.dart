part of 'chat_list_bloc.dart';

sealed class ChatListState {}

final class ChatListInitial extends ChatListState {}

final class ChatListLoading extends ChatListState {}

final class ChatListLoaded extends ChatListState {
  List<ChatListModel> chatList;

  ChatListLoaded({required this.chatList});
}

final class ChatListError extends ChatListState {
  final String errorMsg;

  ChatListError({required this.errorMsg});
}
