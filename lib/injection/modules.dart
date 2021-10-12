import 'package:fineance/injection/bloc_module.dart';
import 'package:fineance/injection/repository_module.dart';
import 'package:fineance/presentation/theme_bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

const String themeBox = 'themeBox';
const IS_LIGHT_THEME = "isLightTheme";

void registerModules(GetIt injector) async {
  injector.registerLazySingleton<Box>(() => Hive.box(themeBox),
      instanceName: themeBox);

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
