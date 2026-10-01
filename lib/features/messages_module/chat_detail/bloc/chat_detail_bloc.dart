import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final ChatRepository _chatRepo;

  ChatDetailBloc({required this._chatRepo}) : super(ChatDetailInitial()) {
    on<ChatDetailFetchRequested>(_onChatDetailFetchRequested);
    on<SendMessagePressed>(_onSendMessagePressed);
  }

  Future<void> _onChatDetailFetchRequested(
    ChatDetailFetchRequested event,
    Emitter<ChatDetailState> emit,
  ) async {
    emit(ChatDetailLoading());
    try {
      final UserModel otherUserProfile = await _chatRepo.fetchUserProfile(
        event.otherUserId,
      );

      final List<String> ids = [event.currentUserid, event.otherUserId]..sort();

      final String chatId = "${ids[0]}_${ids[1]}";

      final UserChatModel? chatData = await _chatRepo.fetchChatSession(chatId);

      emit(
        ChatLoaded(
          receiverUserProfile: otherUserProfile,
          currentChat: chatData,
          chatId: chatId,
        ),
      );
    } catch (e) {
      emit(ChatError(errorMsg: e.toString()));
    }
  }

  Future<void> _onSendMessagePressed(
    SendMessagePressed event,
    Emitter<ChatDetailState> emit,
  ) async {
    final currentState = state;

    if (currentState is ChatLoaded) {
      try {
        await _chatRepo.sendMessage(
          chatId: currentState.chatId,
          senderId: event.currentUserid,
          receiverId: currentState.receiverUserProfile.uid!,
          isGroupChat: false,
          text: event.msgText,
        );

        UserChatModel? updatedChatData = await _chatRepo.fetchChatSession(
          currentState.chatId,
        );

        emit(
          ChatLoaded(
            receiverUserProfile: currentState.receiverUserProfile,
            currentChat: updatedChatData,
            chatId: currentState.chatId,
          ),
        );
      } catch (e) {
        emit(ChatError(errorMsg: e.toString()));
      }
    }
  }
}
