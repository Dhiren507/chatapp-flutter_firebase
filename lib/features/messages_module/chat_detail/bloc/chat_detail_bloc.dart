import 'dart:async';

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
      final List<String> ids = [event.currentUserid, event.otherUserId]..sort();

      final String chatId = "${ids[0]}_${ids[1]}";

      await _chatSubscription?.cancel();

      // final UserChatModel? chatData = await _chatRepo.fetchChatSession(chatId);
      // emit(ChatLoaded(currentChat: chatData, chatId: chatId));

      _chatSubscription = _chatRepo.streamCurrentChatSession(chatId).listen((
        newChatData,
      ) {
        add(ChatDocumentUpdated(chatData: newChatData, chatId: chatId));
      });


    } catch (e) {
      emit(ChatError(errorMsg: e.toString()));
    }
  }

  void _onChatDocumentUpdated(
    ChatDocumentUpdated event,
    Emitter<ChatDetailState> emit,
  ) {
    emit(ChatLoaded(currentChat: event.chatData, chatId: event.chatId));
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
          receiverId: event.receiverUserid,
          isGroupChat: false,
          text: event.msgText,
        );
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

/* Group ke chat ka flow.. */