part of 'chat_detail_bloc.dart';

sealed class ChatDetailEvent {}

class ChatDetailFetchRequested extends ChatDetailEvent {
  final UserModel? otherUserProfile;
  final UserModel? currentUserProfile;
  final String? groupChatId;

  ChatDetailFetchRequested({this.otherUserProfile, this.currentUserProfile, this.groupChatId});
}

class SendMessagePressed extends ChatDetailEvent {
  final List<XFile>? selectedAttachment;
  final String? msgText;

  SendMessagePressed({this.msgText, this.selectedAttachment});
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
