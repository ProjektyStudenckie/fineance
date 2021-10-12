import 'package:bloc/bloc.dart';
import 'package:fineance/injection/modules.dart';
import 'package:fineance/presentation/theme_bloc/theme_bloc.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final Box _themeBox;

  SettingsBloc(this._themeBox)
      : super(const SettingsInitial(theme: ThemeScheme.light)) {
    on<InitializeSettings>((event, emit) {
      emit(SettingsLoaded(theme: event.theme));
    });

    on<ChangeTheme>((event, emit) {
      final newTheme = state.theme == ThemeScheme.light
          ? ThemeScheme.dark
          : ThemeScheme.light;

      _themeBox.put(
          IS_LIGHT_THEME, newTheme == ThemeScheme.light ? true : false);
      emit(SettingsLoaded(theme: newTheme));
    });
  }
}
