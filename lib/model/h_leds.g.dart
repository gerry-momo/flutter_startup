// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'h_leds.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HTodoAdapter extends TypeAdapter<HTodo> {
  @override
  final int typeId = 0;

  @override
  HTodo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HTodo()
      ..createdDate = fields[0] as DateTime
      ..updateDate = fields[1] as DateTime
      ..title = fields[2] as String
      ..context = fields[3] as String
      ..done = fields[4] as bool;
  }

  @override
  void write(BinaryWriter writer, HTodo obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.createdDate)
      ..writeByte(1)
      ..write(obj.updateDate)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.context)
      ..writeByte(4)
      ..write(obj.done);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HTodoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
