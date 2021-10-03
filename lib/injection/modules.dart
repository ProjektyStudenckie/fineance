import 'package:fineance/injection/bloc_module.dart';
import 'package:fineance/injection/repository_module.dart';
import 'package:get_it/get_it.dart';

void registerModules(GetIt injector) {
  registerRepositoryModules(injector);
  registerBlocModules(injector);
}
