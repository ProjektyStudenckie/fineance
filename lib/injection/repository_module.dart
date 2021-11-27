import 'package:fineance/injection/modules.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:fineance/repositories/settings_service.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

void registerRepositoryModules(GetIt injector, LocalAuthentication localAuthentication) {
  injector.registerFactory<AuthenticationRepository>(() => AuthenticationRepositoryImpl(injector.get(), localAuthentication));
  injector.registerFactory<SettingsService>(() => SettingsServiceImpl(injector.get(instanceName: settingsBox)));
}
