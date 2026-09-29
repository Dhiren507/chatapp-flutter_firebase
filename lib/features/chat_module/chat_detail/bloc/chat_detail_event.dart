part of 'chat_detail_bloc.dart';

sealed class ChatDetailEvent {}

class ChatDetailLoaded extends ChatDetailEvent {
  final String otherUserId;

  ChatDetailLoaded({required this.otherUserId});
}
