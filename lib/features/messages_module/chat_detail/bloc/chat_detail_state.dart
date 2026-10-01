part of 'chat_detail_bloc.dart';

enum ChatDetailStatus { initial, loading, loaded, error }

sealed class ChatDetailState {}

final class ChatDetailInitial extends ChatDetailState {}

final class ChatDetailLoading extends ChatDetailState {}

final class ChatLoaded extends ChatDetailState {
  final String chatId;
  final UserChatModel? currentChat;

  ChatLoaded({required this.currentChat, required this.chatId,});
}

final class ChatError extends ChatDetailState {
  final String errorMsg;

  ChatError({required this.errorMsg});
}
