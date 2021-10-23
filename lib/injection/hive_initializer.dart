import 'package:fineance/data/database/fineance_settings_entity/fineance_settings_entity.dart';
import 'package:fineance/injection/modules.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();

  Hive.registerAdapter(FineanceSettingsEntityAdapter());

  await Hive.openBox(themeBox);
  await Hive.openBox(settingsBox);
}
