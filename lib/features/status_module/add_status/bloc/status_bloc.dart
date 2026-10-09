import 'package:chatapp_firebase/features/status_module/data/repositories/status_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'status_event.dart';

part 'status_state.dart';

class StatusBloc extends Bloc<StatusEvent, StatusState> {
  final StatusRepository _statusRepo;

  StatusBloc({required this._statusRepo}) : super(StatusInitial()) {
    on<StatusPostPressed>(_onStatusPostPressed);
  }

  Future<void> _onStatusPostPressed(StatusPostPressed event, Emitter<StatusState> emit) async {
    emit(StatusLoading());

    try {
      await _statusRepo.postStatus(
        userId: event.userId,
        imageLocalPath: event.statusImagePath,
        imageCaption: event.statusCaption,
      );

      emit(StatusPosted());
    } catch (e) {
      emit(StatusError());
    }
  }
}
