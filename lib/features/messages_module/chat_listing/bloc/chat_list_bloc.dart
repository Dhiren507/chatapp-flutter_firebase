import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/chat_list_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/status_module/data/models/user_status.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:chatapp_firebase/features/status_module/data/repositories/status_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository _chatRepo;

  final StatusRepository _statusRepo = StatusRepository();

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

      final List<UserStatus> statusList = await _statusRepo.getAllStatus();

      final List<UserStatus> otherUsersStatuses = statusList
          .where((status) => status.userId != event.currentUserId)
          .toList();

      final UserStatus? currentUserStatus =
          statusList.any((status) => status.userId == event.currentUserId)
          ? statusList.firstWhere(
              (status) => status.userId == event.currentUserId,
            )
          : null;

      if (rawChatList.isEmpty &&
          otherUsersStatuses.isEmpty &&
          currentUserStatus == null) {
        emit(
          ChatListLoaded(chatList: [], statusList: [], currentUserStatus: null),
        );
        return;
      }

      final List<ChatListModel> finalChatList = rawChatList.map((chat) {
        bool isGroup = chat.isGroup ?? false;

        UserModel? otherUserProfile;
        if (!isGroup) {
          otherUserProfile = chat.profiles
              ?.where((profile) => profile.uid != event.currentUserId)
              .toList()
              .firstOrNull;
        }

        final MessageModel? lastChatMessage = chat.messages?.isNotEmpty == true
            ? chat.messages!.last
            : null;

        return ChatListModel(
          chatId: chat.chatId,
          otherUserProfile: otherUserProfile,
          groupName: isGroup ? chat.groupName : null,
          groupProfile: isGroup ? chat.groupProfileUrl : null,
          isGroup: isGroup,
          lastMessage: lastChatMessage,
          lastMessageTimestamp: lastChatMessage?.createdAt,
        );
      }).toList();

      emit(
        ChatListLoaded(
          chatList: finalChatList,
          statusList: otherUsersStatuses,
          currentUserStatus: currentUserStatus,
        ),
      );
    } catch (e) {
      emit(ChatListError(errorMsg: e.toString()));
    }
  }
}
