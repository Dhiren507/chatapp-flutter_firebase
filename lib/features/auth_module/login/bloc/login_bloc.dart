import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
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

  void _onLoginInputFieldChanged(
    LoginInputFieldChanged event,
    Emitter<LoginState> emit,
  ) {
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(state.copyWith(buttonStatus: .enabled));
    } else {
      emit(state.copyWith(buttonStatus: .disabled));
    }
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: .loading));
    try {
      await _authRepository.loginWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: .success));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(
          state.copyWith(
            status: .error,
            errorMsg: 'invalid credentials entered',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: .error,
            errorMsg: 'invalid credentials entered',
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: .error, errorMsg: e.toString()));
    } finally {
      emit(state.copyWith(status: .initial, errorMsg: ''));
    }
  }

  Future<void> _onLoginWithGoogleRequested(
    LoginWithGoogleRequested event,
    Emitter<LoginState> emit,
  ) async {
    emit(state.copyWith(status: .loading));
    try {
      await _authRepository.loginWithGoogle();
      emit(state.copyWith(status: .success));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        emit(
          state.copyWith(
            status: .error,
            errorMsg: 'invalid credentials entered',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: .error,
            errorMsg: 'invalid credentials entered',
          ),
        );
      }
    } catch (e) {
      emit(state.copyWith(status: .error, errorMsg: e.toString()));
    } finally {
      emit(state.copyWith(status: .initial, errorMsg: ''));
    }
  }

  @override
  void onChange(Change<LoginState> change) {
    // TODO: implement onChange
    debugPrint(
      'loing state change: change ${change.currentState.status} to ${change.nextState.status}',
    );
    super.onChange(change);
  }
}
