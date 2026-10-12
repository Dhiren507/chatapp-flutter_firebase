part of 'chat_list_bloc.dart';

enum ChatListStatus { initial, loading, loaded, error }

class ChatListState {
  final ChatListStatus status;
  final List<UserChatModel> chatList;
  final List<UserStatus> statusList;
  final List<UserStatus> currentUserStatuses;
  final UserStatus? currentUserStatus;
  final String? currentUserId;
  final String errorMsg;

  const ChatListState({
    this.status = ChatListStatus.initial,
    this.chatList = const [],
    this.statusList = const [],
    this.currentUserStatuses = const [],
    this.currentUserStatus,
    this.currentUserId,
    this.errorMsg = '',
  });

  ChatListState copyWith({
    ChatListStatus? status,
    List<UserChatModel>? chatList,
    List<UserStatus>? statusList,
    List<UserStatus>? currentUserStatuses,
    UserStatus? currentUserStatus,
    String? currentUserId,
    String? errorMsg,
  }) {
    return ChatListState(
      status: status ?? this.status,
      chatList: chatList ?? this.chatList,
      statusList: statusList ?? this.statusList,
      currentUserStatuses: currentUserStatuses ?? this.currentUserStatuses,
      currentUserStatus: currentUserStatus ?? this.currentUserStatus,
      currentUserId: currentUserId ?? this.currentUserId,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
