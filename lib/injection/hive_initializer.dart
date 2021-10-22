import 'package:fineance/injection/modules.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> setupHive() async {
  await Hive.initFlutter();

  await Hive.openBox(themeBox);
  await Hive.openBox(settingsBox);
}
