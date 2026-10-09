import 'package:chatapp_firebase/features/status_module/data/repositories/status_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'view_status_event.dart';
part 'view_status_state.dart';

class ViewStatusBloc extends Bloc<ViewStatusEvent, ViewStatusState> {
  final StatusRepository _statusRepo;

  ViewStatusBloc({required this._statusRepo}) : super(ViewStatusInitial()) {
    on<MarkStatusAsSeen>(_onMarkStatusAsSeen);
  }

  Future<void> _onMarkStatusAsSeen(MarkStatusAsSeen event, Emitter<ViewStatusState> emit) async {
    await _statusRepo.updateSeenBy(statusId: event.statusId, currentUserId: event.currentUserId);
  }
}
