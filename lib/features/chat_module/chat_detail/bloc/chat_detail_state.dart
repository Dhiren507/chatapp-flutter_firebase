part of 'chat_detail_bloc.dart';

enum ChatDetailStatus { initial, loading, loaded, error }

sealed class ChatDetailState {}

final class ChatDetailInitial extends ChatDetailState {}

final class ChatDetailLoading extends ChatDetailState {}

final class ChatLoaded extends ChatDetailState {
  final UserModel profile;
  final ChatModel? currentChat;

  ChatLoaded({required this.profile, this.currentChat});
}

final class ChatError extends ChatDetailState {
  final String errorMsg;

  ChatError({required this.errorMsg});
}
