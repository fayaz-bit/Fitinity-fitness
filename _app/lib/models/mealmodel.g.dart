// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealCategoryAdapter extends TypeAdapter<MealCategory> {
  @override
  final int typeId = 4;

  @override
  MealCategory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealCategory(
      name: fields[0] as String,
      description: fields[1] as String,
      iconIndex: fields[2] as int,
    );
  }

  @override
  void write(BinaryWriter writer, MealCategory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.description)
      ..writeByte(2)
      ..write(obj.iconIndex);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealCategoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
