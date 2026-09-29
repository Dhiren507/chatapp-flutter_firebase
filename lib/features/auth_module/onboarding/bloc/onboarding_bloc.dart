import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final AuthRepository _authRepository;

  OnboardingBloc({required this._authRepository}) : super(OnboardingInitial()) {
    on<GoogleAuthRequested>(_onLoginWithGoogleRequested);
  }

  Future<void> _onLoginWithGoogleRequested(
    GoogleAuthRequested event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());
    try {
      await _authRepository.loginWithGoogle();
      emit(OnboardingSuccess());
    } catch (e) {
      String errorMsg = (e as dynamic).message ?? e.toString();

      emit(OnboardingError(errorMsg: errorMsg));
    } finally {
      emit(OnboardingInitial());
    }
  }
}
