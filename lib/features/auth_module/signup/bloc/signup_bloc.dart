import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  SignupBloc() : super(SignupInitial()) {
    on<SignupInputFieldChanged>(_onSignupInputFieldChanged);
  }

  void _onSignupInputFieldChanged(
    SignupInputFieldChanged event,
    Emitter<SignupState> emit,
  ) {
    emit(ButtonDisabled());
    if (event.name.isNotEmpty &&
        event.email.isNotEmpty &&
        event.password.isNotEmpty &&
        event.confirmPass.isNotEmpty) {
      emit(ButtonEnabled());
    }
  }
}
