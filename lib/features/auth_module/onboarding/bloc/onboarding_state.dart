part of 'onboarding_bloc.dart';

sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}

final class OnboardingLoading extends OnboardingState {}

final class OnboardingSuccess extends OnboardingState {}

final class OnboardingError extends OnboardingState {
  final String errorMsg;

  OnboardingError({required this.errorMsg});
}
