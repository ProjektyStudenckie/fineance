import 'package:fineance/injection/modules.dart';
import 'package:fineance/repositories/authentication_repository.dart';
import 'package:fineance/repositories/settings_service.dart';
import 'package:fineance/repositories/storage_repository.dart';
import 'package:fineance/repositories/wallets_repository.dart';
import 'package:fineance/repositories/yahoofin.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

void registerRepositoryModules(GetIt injector, LocalAuthentication localAuthentication) {
  injector.registerSingleton<StorageService>(StorageServiceImpl(injector.get(instanceName: tokensBox)));
  injector.registerSingleton<AuthenticationRepository>(AuthenticationRepositoryImpl(injector.get(), localAuthentication, injector.get()));
  injector.registerSingleton<WalletRepository>(WalletRepository(injector.get(), injector.get(), injector.get()));
  injector.registerSingleton<YahooFinRepo>(YahooFinRepo());
  injector.registerSingleton<SettingsService>(SettingsServiceImpl(injector.get(instanceName: settingsBox)));
}
