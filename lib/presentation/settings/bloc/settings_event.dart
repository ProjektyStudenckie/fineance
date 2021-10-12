part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class InitializeSettings extends SettingsEvent {
  final ThemeScheme theme;

  InitializeSettings({required this.theme});
}

class ChangeTheme extends SettingsEvent {}
