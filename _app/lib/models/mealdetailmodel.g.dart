// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mealdetail_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealFieldModelAdapter extends TypeAdapter<MealFieldModel> {
  @override
  final int typeId = 5;

  @override
  MealFieldModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MealFieldModel(
      macrosEnabled: fields[0] as bool,
      proteinEnabled: fields[1] as bool,
      carbsEnabled: fields[2] as bool,
      fatsEnabled: fields[3] as bool,
      caloriesEnabled: fields[4] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, MealFieldModel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.macrosEnabled)
      ..writeByte(1)
      ..write(obj.proteinEnabled)
      ..writeByte(2)
      ..write(obj.carbsEnabled)
      ..writeByte(3)
      ..write(obj.fatsEnabled)
      ..writeByte(4)
      ..write(obj.caloriesEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealFieldModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
