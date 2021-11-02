import 'package:bloc/bloc.dart';
import 'package:fineance/presentation/splash/fineance_quick_actions.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:fineance/repositories/settings_service.dart';
import 'package:meta/meta.dart';

part 'splash_event.dart';
part 'splash_state.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  final SettingsService _settingsService;
  final AuthenticationRepository _authorizationRepository;

  SplashBloc(this._settingsService, this._authorizationRepository)
      : super(SplashLoading()) {
    on<LoadApp>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));

      // TODO: Check if user is logged in

      if (event.quickAction ==
          FineanceQuickActions.REGISTER_NEW_INCOME_EXPENSE) {
        emit(await _handleRegisterNewIncomeExpenseQuickAction());
      } else {
        emit(await _handleLoadingWithoutQuickAction());
      }
    });
  }

  Future<SplashState> _handleRegisterNewIncomeExpenseQuickAction() async {
    if (_settingsService.isBiometricsActive() &&
        await _authorizationRepository.canDeviceUseBiometrics()) {
      return SplashOpenBiometrics(FineanceQuickActions.REGISTER_NEW_INCOME_EXPENSE);
    } else {
      return SplashOpenRegisterIncomeExpense();
    }
  }

  Future<SplashState> _handleLoadingWithoutQuickAction() async {
    if (_settingsService.isBiometricsActive() &&
        await _authorizationRepository.canDeviceUseBiometrics()) {
      return SplashOpenBiometrics();
    } else {
      return SplashOpenHome();
    }
  }
}
