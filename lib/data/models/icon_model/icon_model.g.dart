// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'icon_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class IconModelAdapter extends TypeAdapter<IconModel> {
  @override
  final int typeId = 6;

  @override
  IconModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return IconModel(
      path: fields[0] as String,
      isDefault: fields[1] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, IconModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.path)
      ..writeByte(1)
      ..write(obj.isDefault);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is IconModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
