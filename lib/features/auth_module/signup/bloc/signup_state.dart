part of 'signup_bloc.dart';

sealed class SignupState {}

final class SignupInitial extends SignupState {}

class ButtonEnabled extends SignupState {}

class ButtonDisabled extends SignupState {}
