import 'package:fineance/injection/bloc_module.dart';
import 'package:fineance/injection/repository_module.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';

const String themeBox = 'themeBox';

void registerModules(GetIt injector) {
  injector.registerLazySingleton(() => Hive.box(themeBox),
      instanceName: themeBox);

  registerRepositoryModules(injector);
  registerBlocModules(injector);
}
