part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {
  final ThemeScheme theme;

  const SettingsState({required this.theme});
}

class SettingsInitial extends SettingsState {
  const SettingsInitial({required ThemeScheme theme}): super(theme: theme);
}

class SettingsLoaded extends SettingsState {
  const SettingsLoaded({required ThemeScheme theme}): super(theme: theme);
}
