// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dailygoal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DailyWorkoutAdapter extends TypeAdapter<DailyWorkout> {
  @override
  final int typeId = 6;

  @override
  DailyWorkout read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyWorkout(
      title: fields[0] as String,
      date: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DailyWorkout obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyWorkoutAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
