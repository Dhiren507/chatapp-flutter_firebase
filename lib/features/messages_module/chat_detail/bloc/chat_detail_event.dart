part of 'chat_detail_bloc.dart';

sealed class ChatDetailEvent {}

class ChatDetailFetchRequested extends ChatDetailEvent {
  final UserModel? otherUserProfile;
  final UserModel? currentUserProfile;
  final String? groupChatId;

  ChatDetailFetchRequested({
    this.otherUserProfile,
    this.currentUserProfile,
    this.groupChatId,
  });

}

class SendMessagePressed extends ChatDetailEvent {
  final String? chatId;
  final UserModel? otherUserProfile;
  final UserModel? currentUserProfile;
  final String msgText;

  SendMessagePressed({
    this.chatId,
    required this.msgText,
    this.currentUserProfile,
    this.otherUserProfile,
  });
}

class ChatDocumentUpdated extends ChatDetailEvent {
  final UserChatModel? chatData;
  final UserModel currentUserProfile;
  final UserModel? otherUserProfile;
  final String chatId;

  ChatDocumentUpdated({
    required this.chatData,
    required this.chatId,
    required this.currentUserProfile,
    this.otherUserProfile,
  });
}
