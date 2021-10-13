import 'package:fineance/injection/bloc_module.dart';
import 'package:fineance/injection/repository_module.dart';
import 'package:fineance/presentation/theme_bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

const String themeBox = 'theme_box';
const String settingsBox = "settings_box";

const IS_LIGHT_THEME = "is_light_theme";
const ONBOARDING_DONE = "onboarding_done";

void registerModules(GetIt injector) {
  injector.registerLazySingleton<Box>(() => Hive.box(themeBox),
      instanceName: themeBox);
  injector.registerLazySingleton<Box>(() => Hive.box(settingsBox),
      instanceName: settingsBox);

  registerRepositoryModules(injector);
  registerBlocModules(injector, getSavedTheme());
}

ThemeScheme getSavedTheme() {
  final isLightTheme =
      Hive.box(themeBox).get(IS_LIGHT_THEME, defaultValue: true);

  if (isLightTheme == true) {
    return ThemeScheme.light;
  } else {
    return ThemeScheme.dark;
  }
}
