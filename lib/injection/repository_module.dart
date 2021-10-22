import 'package:fineance/repositories/authorization_repository.dart';
import 'package:get_it/get_it.dart';

void registerRepositoryModules(GetIt injector) {
  injector.registerFactory<AuthorizationRepository>(() =>AuthorizationRepositoryImpl());
}
