import 'package:bloc/bloc.dart';
import 'package:fineance/repositories/settings_service.dart';
import 'package:meta/meta.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SettingsService _settingsService;

  OnboardingBloc(this._settingsService)
      : super(const OnboardingInitial(isBiometricsOn: false)) {
    on<OnboardingInitialize>((event, emit) {
      emit(OnboardingInitial(
          isBiometricsOn: _settingsService.isBiometricsActive()));
    });

    on<ChangeBiometricsState>((event, emit) {
      _settingsService.saveBiometricsOption(event.enable);
      emit(OnboardingInitial(isBiometricsOn: event.enable));
    });
  }
}
