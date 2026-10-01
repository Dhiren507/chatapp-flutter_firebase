part of 'chat_detail_bloc.dart';

sealed class ChatDetailEvent {}

class ChatDetailFetchRequested extends ChatDetailEvent {
  final String currentUserid;
  final String otherUserId;

  ChatDetailFetchRequested({
    required this.otherUserId,
    required this.currentUserid,
  });
}

class SendMessagePressed extends ChatDetailEvent {
  final String currentUserid;
  final String receiverUserid;
  final String msgText;

  SendMessagePressed({required this.msgText, required this.currentUserid, required this.receiverUserid});
}

class ChatDocumentUpdated extends ChatDetailEvent {
  final UserChatModel? chatData;
  final String chatId;
  ChatDocumentUpdated({required this.chatData, required this.chatId});
}

