import 'package:dio/dio.dart';
import 'package:fineance/injection/bloc_module.dart';
import 'package:fineance/injection/repository_module.dart';
import 'package:fineance/networking/api_client.dart';
import 'package:fineance/presentation/theme_bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:local_auth/local_auth.dart';

const String tokensBox = "tokens_box";
const String themeBox = 'theme_box';
const String settingsBox = "settings_box";
const String walletBox = "wallet_box";

const REFRESH_TOKEN = "refresh_token";
const USER_NAME = "user_name";
const ACCESS_TOKEN = "access_token";

const IS_LIGHT_THEME = "is_light_theme";
const IS_ONBOARDING_DONE = "is_onboarding_done";
const FINEANCE_SETTINGS = "fineance_settings";
const CHOSEN_WALLET_INDEX = "chosen_wallet_index";

void registerModules(GetIt injector) {
  injector.registerLazySingleton<Box>(() => Hive.box(tokensBox),
      instanceName: tokensBox);
  injector.registerLazySingleton<Box>(() => Hive.box(themeBox),
      instanceName: themeBox);
  injector.registerLazySingleton<Box>(() => Hive.box(settingsBox),
      instanceName: settingsBox);
  injector.registerLazySingleton<Box>(() => Hive.box(walletBox),
      instanceName: walletBox);

  final LocalAuthentication localAuthentication = LocalAuthentication();

  final dio = Dio();
  injector.registerFactory<ApiClient>(() => ApiClient(dio));

  registerRepositoryModules(injector, localAuthentication);
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
