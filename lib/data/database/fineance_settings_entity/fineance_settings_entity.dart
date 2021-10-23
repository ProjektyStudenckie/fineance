import 'package:hive/hive.dart';

part 'fineance_settings_entity.g.dart';

@HiveType(typeId: 1)
class FineanceSettingsEntity {
  @HiveField(0)
  final bool isBiometricsActive;

  FineanceSettingsEntity({
    required this.isBiometricsActive,
  });

  FineanceSettingsEntity copyWith({bool? isBiometricsActive}) =>
      FineanceSettingsEntity(
          isBiometricsActive: isBiometricsActive ?? this.isBiometricsActive);
}
