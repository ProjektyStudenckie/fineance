import 'package:fineance/data/database/fineance_settings_entity/fineance_settings_entity.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/presentation/settings/models/fineance_settings.dart';
import 'package:hive/hive.dart';

abstract class SettingsService {
  void saveFineanceSettings(FineanceSettings fineanceSettings);

  FineanceSettings getFineanceSettings();

  void saveBiometricsOption(bool enableBiometrics);

  bool isBiometricsActive();
}

class SettingsServiceImpl implements SettingsService {
  final Box _settingsBox;

  SettingsServiceImpl(this._settingsBox);

  @override
  FineanceSettings getFineanceSettings() {
    final response = _settingsBox.get(FINEANCE_SETTINGS);

    FineanceSettingsEntity? settings;

    if (response is FineanceSettingsEntity) {
      settings = response;
    }

    return FineanceSettings(
        isBiometricsActive: settings?.isBiometricsActive ?? false);
  }

  @override
  void saveFineanceSettings(FineanceSettings fineanceSettings) async {
    final settings = FineanceSettingsEntity(
        isBiometricsActive: fineanceSettings.isBiometricsActive);

    await _settingsBox.clear();
    await _settingsBox.put(FINEANCE_SETTINGS, settings);
  }

  @override
  bool isBiometricsActive() {
    return getFineanceSettings().isBiometricsActive;
  }

  @override
  void saveBiometricsOption(bool enableBiometrics) async {
    final settings = getFineanceSettings();
    saveFineanceSettings(settings.copyWith(isBiometricsActive: enableBiometrics));
  }
}
