import 'package:fineance/repositories/authentication_repository.dart';
import 'package:get_it/get_it.dart';

// void registerRepositoryModules(GetIt injector) {
//   injector.registerFactory<AuthorizationRepository>(() =>AuthorizationRepositoryImpl());
// }
void registerRepositoryModules(GetIt injector) {
  injector.registerFactory<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
}
