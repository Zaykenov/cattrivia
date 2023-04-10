// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hiveinfo.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CatInfoAdapter extends TypeAdapter<CatInfo> {
  @override
  final int typeId = 0;

  @override
  CatInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CatInfo(
      updatedAt: fields[0] as String,
      text: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CatInfo obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.updatedAt)
      ..writeByte(1)
      ..write(obj.text);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CatInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
