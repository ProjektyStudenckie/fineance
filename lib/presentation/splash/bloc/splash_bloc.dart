import 'package:bloc/bloc.dart';
import 'package:fineance/repositories/settings_service.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SettingsService _settingsService;

  SplashBloc(this._settingsService) : super(SplashLoading()) {
    on<LoadApp>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Check if user is logged in

      if (_settingsService.isBiometricsActive()) {
        emit(SplashOpenBiometrics());
      } else {
        emit(SplashOpenHome());
      }
    });
  }
}
