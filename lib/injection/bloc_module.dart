import 'package:fineance/injection/modules.dart';
import 'package:fineance/presentation/authorization/login/bloc/login_bloc.dart';
import 'package:fineance/presentation/authorization/register/bloc/register_bloc.dart';
import 'package:fineance/presentation/home/bloc/home_bloc.dart';
import 'package:fineance/presentation/settings/bloc/settings_bloc.dart';
import 'package:fineance/presentation/splash/bloc/splash_bloc.dart';
import 'package:fineance/presentation/theme_bloc/theme_bloc.dart';
import 'package:get_it/get_it.dart';

void registerBlocModules(GetIt injector, ThemeScheme theme) {
  injector.registerFactory(() => ThemeBloc(theme));
  injector.registerFactory(() => SplashBloc());
  injector.registerFactory(() => LoginBloc(injector.get(), injector.get(instanceName: settingsBox)));
  injector.registerFactory(() => RegisterBloc(injector.get(), injector.get(instanceName: settingsBox)));
  injector.registerFactory(() => HomeBloc());
  injector.registerFactory(() => SettingsBloc(injector.get(instanceName: themeBox)));
}
