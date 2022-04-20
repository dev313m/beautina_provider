// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DBLocalTokenAdapter extends TypeAdapter<DBLocalToken> {
  @override
  final int typeId = 2;

  @override
  DBLocalToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DBLocalToken()..token = fields[0] as String;
  }

  @override
  void write(BinaryWriter writer, DBLocalToken obj) {
    writer
      ..writeByte(1)
      ..writeByte(0)
      ..write(obj.token);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DBLocalTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
