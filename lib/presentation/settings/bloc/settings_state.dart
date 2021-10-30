part of 'settings_bloc.dart';

@immutable
abstract class SettingsState {}

class SettingsInitializing extends SettingsState {}

class SettingsLoaded extends SettingsState {
  final FineanceSettings settings;

  SettingsLoaded({required this.settings});
}
