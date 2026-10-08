part of 'create_group_bloc.dart';

sealed class CreateGroupState {}

final class CreateGroupInitial extends CreateGroupState {}

final class CreateGroupLoading extends CreateGroupState {}

final class CreateGroupLoaded extends CreateGroupState {
  final List<UserModel> members;
  final UserModel adminProfile;

  CreateGroupLoaded({this.members = const [], required this.adminProfile});
}

final class CreateGroupError extends CreateGroupState {
  final String errorMsg;

  CreateGroupError({required this.errorMsg});
}
