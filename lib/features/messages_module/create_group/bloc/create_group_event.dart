part of 'create_group_bloc.dart';

sealed class CreateGroupEvent {}

final class CreateGroupSubmitted extends CreateGroupEvent {
  final String groupId;
  final String groupTitle;
  final UserModel groupAdminProfile;
  final List<UserModel> members;

  CreateGroupSubmitted({
    required this.groupId,
    required this.groupTitle,
    required this.groupAdminProfile,
    required this.members,
  });
}

final class CreateGroupMembersChanged extends CreateGroupEvent {
  final List<UserModel> members;

  CreateGroupMembersChanged({required this.members});
}

final class CreateGroupStarted extends CreateGroupEvent {
  final List<UserModel> members;
  final UserModel adminProfile;

  CreateGroupStarted({this.members = const [], required this.adminProfile});
}
