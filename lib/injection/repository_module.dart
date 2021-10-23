import 'package:fineance/injection/modules.dart';
import 'package:fineance/repositories/authorization_repository.dart';
import 'package:fineance/repositories/settings_service.dart';
import 'package:get_it/get_it.dart';

void registerRepositoryModules(GetIt injector) {
  injector.registerFactory<AuthorizationRepository>(() => AuthorizationRepositoryImpl());
  injector.registerFactory<SettingsService>(() => SettingsServiceImpl(injector.get(instanceName: settingsBox)));
}
