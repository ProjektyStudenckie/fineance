part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingState {
  final bool isBiometricsOn;

  const OnboardingState({required this.isBiometricsOn});
}

class OnboardingInitial extends OnboardingState {
  const OnboardingInitial({required bool isBiometricsOn})
      : super(isBiometricsOn: isBiometricsOn);
}
