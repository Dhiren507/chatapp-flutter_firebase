import 'package:chatapp_firebase/features/messages_module/data/models/chat_list_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_list_event.dart';
part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository _chatRepo;

  ChatListBloc({required this._chatRepo}) : super(ChatListInitial()) {
    on<ChatListFetchRequested>(_onChatListFetchRequested);
  }

  Future<void> _onChatListFetchRequested(
    ChatListFetchRequested event,
    Emitter<ChatListState> emit,
  ) async {
    emit(ChatListLoading());

    try {
      final List<UserChatModel> rawChatList = await _chatRepo.fetchUserChatList(
        event.currentUserId,
      );

      print('this is the list of chatListModels $rawChatList');

      if (rawChatList == []) {
        emit(ChatListLoaded(chatList: []));
      }

      final List<ChatListModel> finalChatList = rawChatList.map((chat) {
        final otherUserProfile = chat.profiles?.firstWhere(
          (profile) => profile.uid != event.currentUserId,
        );

        final MessageModel? lastChatMessage = chat.messages?.last;

        return ChatListModel(
          chatId: chat.chatId,
          otherUserProfile: otherUserProfile,
          lastMessage: lastChatMessage,
          lastMessageTimestamp: lastChatMessage?.createdAt,
        );
      }).toList();

      emit(ChatListLoaded(chatList: finalChatList));
    } catch (e) {
      emit(ChatListError(errorMsg: e.toString()));
    }
  }
}
