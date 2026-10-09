part of 'status_bloc.dart';

sealed class StatusState {}

final class StatusInitial extends StatusState {}

final class StatusLoading extends StatusState {}

final class StatusPosted extends StatusState {}

final class StatusError extends StatusState {}
