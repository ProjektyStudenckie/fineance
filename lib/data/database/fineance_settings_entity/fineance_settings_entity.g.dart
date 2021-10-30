// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fineance_settings_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FineanceSettingsEntityAdapter
    extends TypeAdapter<FineanceSettingsEntity> {
  @override
  final int typeId = 1;

  @override
  FineanceSettingsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FineanceSettingsEntity(
      isBiometricsActive: fields[0] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, FineanceSettingsEntity obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.isBiometricsActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FineanceSettingsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
