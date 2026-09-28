import 'package:chatapp_firebase/features/auth_module/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository _authRepository;

  SignupBloc({required this._authRepository}) : super(SignupState()) {
    on<SignupInputFieldChanged>(_onSignupInputFieldChanged);
    on<SignupRequested>(_onSignupRequested);
  }

  void _onSignupInputFieldChanged(
    SignupInputFieldChanged event,
    Emitter<SignupState> emit,
  ) {
    if (event.name.isNotEmpty &&
        event.email.isNotEmpty &&
        event.password.isNotEmpty &&
        event.confirmPass.isNotEmpty) {
      emit(state.copyWith(buttonStatus: .enabled));
    } else {
      emit(state.copyWith(buttonStatus: .disabled));
    }
  }

  Future<void> _onSignupRequested(
    SignupRequested event,
    Emitter<SignupState> emit,
  ) async {
    emit(state.copyWith(status: .loading));
    try {
      await _authRepository.signUpAndCreateUser(
        name: event.name,
        email: event.email,
        password: event.password,
      );
      emit(state.copyWith(status: .success));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(state.copyWith(status: .error, errorMsg: 'Email Already Exists'));
      }
    } catch (e) {
      emit(state.copyWith(status: .error, errorMsg: e.toString()));
    } finally {
      emit(state.copyWith(status: .initial, errorMsg: ''));
    }
  }
}
