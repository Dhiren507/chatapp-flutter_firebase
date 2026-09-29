import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/chat_module/chat_detail/data/repositories/chat_repository.dart';
import 'package:chatapp_firebase/features/chat_module/chat_detail/models/chat_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'chat_detail_event.dart';
part 'chat_detail_state.dart';

class ChatDetailBloc extends Bloc<ChatDetailEvent, ChatDetailState> {
  final ChatRepository _chatRepo;

  ChatDetailBloc({required this._chatRepo}) : super(ChatDetailInitial()) {
    on<ChatDetailLoaded>(_onChatDetailLoaded);
  }

  Future<void> _onChatDetailLoaded(
    ChatDetailLoaded event,
    Emitter<ChatDetailState> emit,
  ) async {
    emit(ChatDetailLoading());
    try {
      final UserModel otherUserProfile = await _chatRepo.fetchUserProfile(
        event.otherUserId,
      );

      // we will also need to check in here if the chats collection if chatId with current_user_id and other_user id exists then fetch the chatJson and load the data

      emit(ChatLoaded(profile: otherUserProfile));
    } catch (e) {
      emit(ChatError(errorMsg: e.toString()));
    }
  }
}
