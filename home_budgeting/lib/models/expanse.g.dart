// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expanse.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExpanseAdapter extends TypeAdapter<Expanse> {
  @override
  final int typeId = 0;

  @override
  Expanse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Expanse(
      payee: fields[0] as String,
      description: fields[2] as String,
      price: fields[1] as int,
      date: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Expanse obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.payee)
      ..writeByte(1)
      ..write(obj.price)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpanseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
