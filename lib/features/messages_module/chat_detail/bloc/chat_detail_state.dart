part of 'chat_detail_bloc.dart';

enum ChatDetailStatus { initial, loading, loaded, error }

final class ChatDetailState {
  final ChatDetailStatus status;
  final String? chatId;
  final UserChatModel? currentChat;
  final UserModel? currentUserProfile;
  final UserModel? otherUserProfile;
  final String errorMsg;

  ChatDetailState({
    this.status = .initial,
    this.currentChat,
    this.chatId,
    this.currentUserProfile,
    this.otherUserProfile,
    this.errorMsg = '',
  });

  ChatDetailState copyWith({
    ChatDetailStatus? status,
    String? chatId,
    UserChatModel? currentChat,
    UserModel? currentUserProfile,
    UserModel? otherUserProfile,
    String? errorMsg,
  }) {
    return ChatDetailState(
      status: status ?? this.status,
      chatId: chatId ?? this.chatId,
      currentChat: currentChat ?? this.currentChat,
      currentUserProfile: currentUserProfile ?? this.currentUserProfile,
      otherUserProfile: otherUserProfile ?? this.otherUserProfile,
      errorMsg: errorMsg ?? this.errorMsg,
    );
  }
}
