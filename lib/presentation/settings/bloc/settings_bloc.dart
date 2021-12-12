import 'package:bloc/bloc.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/presentation/settings/models/fineance_settings.dart';
import 'package:fineance/repositories/settings_service.dart';
import 'package:fineance/repositories/storage_repository.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final SettingsService _settingsService;
  final StorageService _storageService;
  final Box _themeBox;

  SettingsBloc(this._settingsService, this._themeBox, this._storageService)
      : super(SettingsInitializing()) {
    on<InitializeSettings>((event, emit) {
      final settings = _settingsService.getFineanceSettings();
      emit(SettingsLoaded(settings: settings));
    });

    on<ChangeTheme>((event, emit) {
      _themeBox.put(IS_LIGHT_THEME, !event.isDarkTheme);

      emit(SettingsLoaded(settings: event.settings));
    });

    on<ChangeBiometricsOption>((event, emit) {
      final updatedSettings =
          event.settings.copyWith(isBiometricsActive: event.enable);
      _settingsService.saveFineanceSettings(updatedSettings);

      emit(SettingsLoaded(settings: updatedSettings));
    });

    on<LogOUT>((event, emit) {
      _storageService.saveUserName("");
      _storageService.saveTokens("", "");
    });
  }
}
