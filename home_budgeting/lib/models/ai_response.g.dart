// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AiResponeAdapter extends TypeAdapter<AiRespone> {
  @override
  final int typeId = 1;

  @override
  AiRespone read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AiRespone(
      query: fields[0] as String,
      reponse: fields[1] as String,
      date: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AiRespone obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.query)
      ..writeByte(1)
      ..write(obj.reponse)
      ..writeByte(2)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AiResponeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
