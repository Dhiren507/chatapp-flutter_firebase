import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/status_module/data/repositories/status_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'view_status_event.dart';
part 'view_status_state.dart';

class ViewStatusBloc extends Bloc<ViewStatusEvent, ViewStatusState> {
  final StatusRepository _statusRepo;

  ViewStatusBloc({required this._statusRepo}) : super(const ViewStatusInitial()) {
    on<MarkStatusAsSeen>(_onMarkStatusAsSeen);
    on<StatusIndexChanged>(_onStatusIndexChanged);
    on<DeleteStatus>(_onDeleteStatus);
    on<FetchStatusViewers>(_onFetchStatusViewers);
  }

  Future<void> _onMarkStatusAsSeen(MarkStatusAsSeen event, Emitter<ViewStatusState> emit) async {
    await _statusRepo.updateSeenBy(statusId: event.statusId, currentUserId: event.currentUserId);
  }

  void _onStatusIndexChanged(StatusIndexChanged event, Emitter<ViewStatusState> emit) {
    emit(state.copyWith(currentIndex: event.index, viewers: []));
  }

  Future<void> _onDeleteStatus(DeleteStatus event, Emitter<ViewStatusState> emit) async {
    emit(state.copyWith(isDeleting: true));
    try {
      await _statusRepo.deleteStatus(statusId: event.statusId);
      emit(state.copyWith(isDeleting: false, isDeleted: true));
    } catch (_) {
      emit(state.copyWith(isDeleting: false));
    }
  }

  Future<void> _onFetchStatusViewers(FetchStatusViewers event, Emitter<ViewStatusState> emit) async {
    emit(state.copyWith(isLoadingViewers: true));
    try {
      final viewers = await _statusRepo.getViewers(event.viewerIds);
      emit(state.copyWith(isLoadingViewers: false, viewers: viewers));
    } catch (_) {
      emit(state.copyWith(isLoadingViewers: false));
    }
  }
}
