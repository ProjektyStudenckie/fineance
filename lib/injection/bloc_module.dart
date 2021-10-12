import 'package:fineance/injection/modules.dart';
import 'package:fineance/presentation/home/bloc/home_bloc.dart';
import 'package:fineance/presentation/settings/bloc/settings_bloc.dart';
import 'package:fineance/presentation/splash/bloc/splash_bloc.dart';
import 'package:fineance/presentation/theme_bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';

void registerBlocModules(GetIt injector, ThemeScheme theme) {
  injector.registerFactory(() => ThemeBloc(theme));
  injector.registerFactory(() => SplashBloc());
  injector.registerFactory(() => HomeBloc());
  injector.registerFactory(() => SettingsBloc(injector.get(instanceName: themeBox)));
}
