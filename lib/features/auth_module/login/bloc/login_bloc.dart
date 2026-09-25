import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial()) {
    on<LoginInputFieldChanged>(_onLoginInputFieldChanged);
  }

  void _onLoginInputFieldChanged(
    LoginInputFieldChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(ButtonDisabled());
    if (event.email.isNotEmpty && event.password.isNotEmpty) {
      emit(ButtonEnabled());
    }
  }
}
