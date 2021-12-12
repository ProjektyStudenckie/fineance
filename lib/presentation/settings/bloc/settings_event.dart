part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class InitializeSettings extends SettingsEvent {}

class ChangeTheme extends SettingsEvent {
  final bool isDarkTheme;
  final FineanceSettings settings;

  ChangeTheme({required this.isDarkTheme, required this.settings});
}

class ChangeBiometricsOption extends SettingsEvent {
  final bool enable;
  final FineanceSettings settings;

  ChangeBiometricsOption({required this.enable, required this.settings});
}


class LogOUT extends SettingsEvent {
  LogOUT();
}
