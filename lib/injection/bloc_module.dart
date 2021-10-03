import 'package:fineance/presentation/home/bloc/home_bloc.dart';
import 'package:fineance/presentation/settings/bloc/settings_bloc.dart';
import 'package:fineance/presentation/splash/bloc/splash_bloc.dart';
import 'package:get_it/get_it.dart';

void registerBlocModules(GetIt injector) {
  injector.registerFactory(() => SplashBloc());
  injector.registerFactory(() => HomeBloc());
  injector.registerFactory(() => SettingsBloc());
}
