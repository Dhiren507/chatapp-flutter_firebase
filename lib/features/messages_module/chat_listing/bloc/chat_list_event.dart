part of 'chat_list_bloc.dart';

sealed class ChatListEvent {}

final class ChatListFetchRequested extends ChatListEvent {
  final String currentUserId;

  ChatListFetchRequested({required this.currentUserId});
}

class ChatListUpdated extends ChatListEvent {
  final String currentUserid;
  final List<UserChatModel> chats;

  ChatListUpdated({required this.chats, required this.currentUserid});
}

class StatusListUpdated extends ChatListEvent {
  final String currentUserid;
  final List<UserStatus> allStatuses;

  StatusListUpdated({required this.allStatuses, required this.currentUserid});
}

class ChatListErrorOccurred extends ChatListEvent {
  final String errorMsg;

  ChatListErrorOccurred({required this.errorMsg});
}
