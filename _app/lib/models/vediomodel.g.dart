part of 'vedio_model.dart';

class AdminVideoModelAdapter extends TypeAdapter<AdminVideoModel> {
  @override
  final int typeId = 3;

  @override
  AdminVideoModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AdminVideoModel(
      workoutName: fields[0] as String,
      videoTitleEnabled: fields[1] as bool,
      videoUrlEnabled: fields[2] as bool,
      videoFileEnabled: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, AdminVideoModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.workoutName)
      ..writeByte(1)
      ..write(obj.videoTitleEnabled)
      ..writeByte(2)
      ..write(obj.videoUrlEnabled)
      ..writeByte(3)
      ..write(obj.videoFileEnabled);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AdminVideoModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
