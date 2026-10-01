part of 'chat_list_bloc.dart';

sealed class ChatListEvent {}

final class ChatListFetchRequested extends ChatListEvent {
  final String currentUserId;

  ChatListFetchRequested({required this.currentUserId});
}
