import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/messages_module/data/repositories/chat_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_group_event.dart';
part 'create_group_state.dart';

class CreateGroupBloc extends Bloc<CreateGroupEvent, CreateGroupState> {
  final ChatRepository _chatRepo;

  CreateGroupBloc({required this._chatRepo}) : super(CreateGroupInitial()) {
    on<CreateGroupStarted>(_onCreateGroupStarted);
    on<CreateGroupMembersChanged>(_onCreateGroupMembersChanged);
    on<CreateGroupSubmitted>(_onCreateGroupSubmitted);
  }

  void _onCreateGroupStarted(CreateGroupStarted event, Emitter<CreateGroupState> emit) {
    emit(CreateGroupLoading());
    try {
      emit(CreateGroupLoaded(adminProfile: event.adminProfile));
    } catch (e) {
      emit(CreateGroupError(errorMsg: e.toString()));
    }
  }

  void _onCreateGroupMembersChanged(CreateGroupMembersChanged event, Emitter<CreateGroupState> emit) {
    if (state is CreateGroupLoaded) {
      final currentState = state as CreateGroupLoaded;

      emit(CreateGroupLoaded(adminProfile: currentState.adminProfile, members: event.members));
    }
  }

  Future<void> _onCreateGroupSubmitted(CreateGroupSubmitted event, Emitter<CreateGroupState> emit) async {
    emit(CreateGroupLoading());
    try {
      await _chatRepo.createNewGroup(event.groupId, event.groupTitle, event.groupAdminProfile, event.members);

      emit(CreateGroupInitial());
    } catch (e) {
      emit(CreateGroupError(errorMsg: e.toString()));
    }
  }
}
