import 'dart:async';

import 'package:chatapp_firebase/features/messages_module/data/models/user_chat_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:chatapp_firebase/features/status_module/data/models/user_status.dart';
import 'package:chatapp_firebase/features/status_module/data/repositories/status_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_list_event.dart';

part 'chat_list_state.dart';

class ChatListBloc extends Bloc<ChatListEvent, ChatListState> {
  final ChatRepository _chatRepo;
  final StatusRepository _statusRepo = StatusRepository();

  StreamSubscription? _chatListSubscription;
  StreamSubscription? _statusSubscription;

  ChatListBloc({required this._chatRepo}) : super(const ChatListState()) {
    on<ChatListFetchRequested>(_onChatListFetchRequested);
    on<ChatListUpdated>(_onChatListUpdated);
    on<StatusListUpdated>(_onStatusListUpdated);
    on<ChatListErrorOccurred>(_onChatListErrorOccurred);
  }

  Future<void> _onChatListFetchRequested(ChatListFetchRequested event, Emitter<ChatListState> emit) async {
    emit(state.copyWith(status: .loading));

    await _chatListSubscription?.cancel();
    await _statusSubscription?.cancel();

    _chatListSubscription = _chatRepo
        .streamChatList(event.currentUserId)
        .listen(
          (chats) => add(ChatListUpdated(chats: chats, currentUserid: event.currentUserId)),
          onError: (err) => add(ChatListErrorOccurred(errorMsg: err.toString())),
        );

    _statusSubscription = _statusRepo.streamAllStatus().listen(
      (statuses) => add(StatusListUpdated(allStatuses: statuses, currentUserid: event.currentUserId)),
      onError: (err) => add(ChatListErrorOccurred(errorMsg: err.toString())),
    );
  }

  void _onChatListUpdated(ChatListUpdated event, Emitter<ChatListState> emit) {
    emit(state.copyWith(status: .loaded, chatList: event.chats, currentUserId: event.currentUserid));
  }

  void _onStatusListUpdated(StatusListUpdated event, Emitter<ChatListState> emit) {
    final otherUsersStatuses = event.allStatuses
        .where((status) => status.userId != event.currentUserid)
        .toList();

    final currentUserStatus = event.allStatuses.cast<UserStatus?>().firstWhere(
      (status) => status?.userId == event.currentUserid,
      orElse: () => null,
    );

    emit(
      state.copyWith(
        status: ChatListStatus.loaded,
        statusList: otherUsersStatuses,
        currentUserStatus: currentUserStatus,
        currentUserId: event.currentUserid,
      ),
    );
  }

  void _onChatListErrorOccurred(ChatListErrorOccurred event, Emitter<ChatListState> emit) {
    emit(state.copyWith(status: .error, errorMsg: event.errorMsg));
  }

  @override
  Future<void> close() {
    _chatListSubscription?.cancel();
    _statusSubscription?.cancel();
    return super.close();
  }
}
