import 'dart:async';

import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final ChatRepository _chatRepo;
  StreamSubscription<UserChatModel?>? _chatSubscription;

  ChatDetailBloc({required this._chatRepo}) : super(ChatDetailInitial()) {
    on<ChatDetailFetchRequested>(_onChatDetailFetchRequested);
    on<SendMessagePressed>(_onSendMessagePressed);
    on<ChatDocumentUpdated>(_onChatDocumentUpdated);
  }

  Future<void> _onChatDetailFetchRequested(
    ChatDetailFetchRequested event,
    Emitter<ChatDetailState> emit,
  ) async {
    emit(ChatDetailLoading());
    try {
      String chatId;

      if (event.groupChatId == null) {
        final List<String> ids = [
          event.currentUserProfile!.uid!,
          event.otherUserProfile!.uid!,
        ]..sort();

        chatId = "${ids[0]}_${ids[1]}";
      } else {
        chatId = event.groupChatId!;
      }

      await _chatSubscription?.cancel();

      _chatSubscription = _chatRepo.streamCurrentChatSession(chatId).listen((
        newChatData,
      ) {
        if (newChatData?.isGroup == true) {
          add(
            ChatDocumentUpdated(
              chatData: newChatData,
              chatId: chatId,
              currentUserProfile: event.currentUserProfile!,
            ),
          );
        } else {
          add(
            ChatDocumentUpdated(
              chatData: newChatData,
              chatId: chatId,
              currentUserProfile: event.currentUserProfile!,
              otherUserProfile: event.otherUserProfile!,
            ),
          );
        }
      });
    } catch (e) {
      emit(ChatError(errorMsg: e.toString()));
    }
  }

  void _onChatDocumentUpdated(
    ChatDocumentUpdated event,
    Emitter<ChatDetailState> emit,
  ) {
    emit(
      ChatLoaded(
        currentChat: event.chatData,
        chatId: event.chatId,
        currentUserProfile: event.currentUserProfile,
        otherUserProfile: event.otherUserProfile,
      ),
    );
  }

  Future<void> _onSendMessagePressed(
    SendMessagePressed event,
    Emitter<ChatDetailState> emit,
  ) async {
    final currentState = state;

    if (currentState is ChatLoaded) {
      try {
        if (event.isGroup == false) {
          await _chatRepo.sendMessage(
            chatId: currentState.chatId,
            sender: event.currentUserProfile!,
            receiver: event.otherUserProfile!,
            isGroupChat: false,
            text: event.msgText,
          );
        } else {
          await _chatRepo.sendMessage(
            chatId: currentState.chatId,
            sender: event.currentUserProfile!,
            isGroupChat: true,
            text: event.msgText,
          );
        }
      } catch (e) {
        emit(ChatError(errorMsg: e.toString()));
      }
    }
  }

  @override
  Future<void> close() async {
    // TODO: implement close
    await _chatSubscription?.cancel();
    return super.close();
  }
}
