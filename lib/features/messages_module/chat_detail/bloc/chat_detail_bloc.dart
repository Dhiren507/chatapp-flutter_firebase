import 'dart:async';

import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/core/services/cloudinary_service.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

part 'chat_detail_event.dart';

part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final ChatRepository _chatRepo;
  StreamSubscription<UserChatModel?>? _chatSubscription;

  ChatDetailBloc({required this._chatRepo}) : super(ChatDetailState()) {
    on<ChatDetailFetchRequested>(_onChatDetailFetchRequested);
    on<SendMessagePressed>(_onSendMessagePressed);
    on<ChatDocumentUpdated>(_onChatDocumentUpdated);
  }

  Future<void> _onChatDetailFetchRequested(
    ChatDetailFetchRequested event,
    Emitter<ChatDetailState> emit,
  ) async {
    emit(state.copyWith(status: .loading));
    try {
      String chatId;

      if (event.groupChatId == null) {
        final List<String> ids = [event.currentUserProfile!.uid!, event.otherUserProfile!.uid!]..sort();

        chatId = "${ids[0]}_${ids[1]}";
      } else {
        chatId = event.groupChatId!;
      }

      await _chatSubscription?.cancel();

      _chatSubscription = _chatRepo.streamCurrentChatSession(chatId).listen((newChatData) {
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
      emit(ChatDetailState(status: .error, errorMsg: e.toString()));
    }
  }

  void _onChatDocumentUpdated(ChatDocumentUpdated event, Emitter<ChatDetailState> emit) {
    emit(
      ChatDetailState(
        status: .loaded,
        chatId: event.chatId,
        currentChat: event.chatData,
        currentUserProfile: event.currentUserProfile,
        otherUserProfile: event.otherUserProfile,
      ),
    );
  }

  Future<void> _onSendMessagePressed(SendMessagePressed event, Emitter<ChatDetailState> emit) async {
    if (state.status == .loaded) {
      try {
        List<String> mediaUrls = [];
        final String cloudPath = 'chat_app/chat_media/${state.chatId}';

        if (event.selectedAttachment != null || event.selectedAttachment == []) {
          emit(state.copyWith(status: .loading));

          for (final attachment in event.selectedAttachment!) {
            final downloadUrl = await CloudinaryService.instance.uploadImageCustomPath(
              localPath: attachment.path,
              uploadFolderPath: cloudPath,
            );

            if (downloadUrl != null) {
              mediaUrls.add(downloadUrl);
            }
          }
        }

        final String mediaType = mediaUrls.isNotEmpty ? 'image' : '';

        if (state.currentChat?.isGroup == true) {
          await _chatRepo.sendMessage(
            chatId: state.chatId!,
            sender: state.currentUserProfile!,
            isGroupChat: true,
            text: event.msgText ?? '',
            mediaUrls: mediaUrls,
            mediaType: mediaType,
          );
        } else {
          await _chatRepo.sendMessage(
            chatId: state.chatId!,
            sender: state.currentUserProfile!,
            receiver: state.otherUserProfile!,
            isGroupChat: false,
            text: event.msgText ?? '',
            mediaUrls: mediaUrls,
            mediaType: mediaType,
          );
        }
      } catch (e) {
        emit(ChatDetailState(status: .error, errorMsg: e.toString()));
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
