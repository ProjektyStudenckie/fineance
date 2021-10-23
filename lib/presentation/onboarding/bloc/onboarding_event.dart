part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {}

class OnboardingInitialize extends OnboardingEvent {}

class ChangeBiometricsState extends OnboardingEvent {
  final bool enable;

  ChangeBiometricsState({required this.enable});
}
