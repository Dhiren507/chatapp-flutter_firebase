import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository _authRepository;

  LoginBloc({required this._authRepository}) : super(LoginState()) {
    on<LoginInputFieldChanged>(_onLoginInputFieldChanged);
    on<LoginRequested>(_onLoginRequested);
    on<LoginWithGoogleRequested>(_onLoginWithGoogleRequested);
  }

  void _onLoginInputFieldChanged(LoginInputFieldChanged event, Emitter<LoginState> emit) {
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(state.copyWith(buttonStatus: .enabled));
    } else {
      emit(state.copyWith(buttonStatus: .disabled));
    }
  }

  Future<void> _onLoginRequested(LoginRequested event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _authRepository.loginWithEmailAndPassword(email: event.email, password: event.password);
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e, stackTrace) {
      debugPrint('Login Error: $e');
      debugPrint('Login Stack: $stackTrace');
      String errorMsg = (e as dynamic).message ?? e.toString();

      emit(state.copyWith(status: LoginStatus.error, errorMsg: errorMsg));
    }
  }

  Future<void> _onLoginWithGoogleRequested(LoginWithGoogleRequested event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      await _authRepository.loginWithGoogle();
      emit(state.copyWith(status: LoginStatus.success));
    } catch (e, stackTrace) {
      debugPrint('Google Auth Error: $e');
      debugPrint('Google Auth Stack: $stackTrace');
      String errorMsg = (e as dynamic).message ?? e.toString();

      emit(state.copyWith(status: LoginStatus.error, errorMsg: errorMsg));
    }
  }

  @override
  void onChange(Change<LoginState> change) {
    // TODO: implement onChange
    debugPrint('loing state change: change ${change.currentState.status} to ${change.nextState.status}');
    super.onChange(change);
  }
}
