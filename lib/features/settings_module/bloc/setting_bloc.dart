import 'package:chatapp_firebase/core/data/models/user_model.dart';
import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_event.dart';

part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  final AuthRepository authRepository;

  SettingBloc({required this.authRepository}) : super(const SettingState()) {
    on<SettingProfileFetchRequested>(_onProfileFetchRequested);
  }

  Future<void> _onProfileFetchRequested(
    SettingProfileFetchRequested event,
    Emitter<SettingState> emit,
  ) async {
    emit(state.copyWith(status: SettingStatus.loading));
    try {
      final userProfile = await authRepository.getCurrentUserProfile();
      emit(state.copyWith(status: SettingStatus.loaded, userProfile: userProfile));
    } catch (e) {
      emit(state.copyWith(status: SettingStatus.error, errorMsg: e.toString()));
    }
  }
}
