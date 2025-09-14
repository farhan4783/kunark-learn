// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_lesson_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedLessonAdapter extends TypeAdapter<SavedLesson> {
  @override
  final int typeId = 0;

  @override
  SavedLesson read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedLesson(
      topic: fields[0] as String,
      content: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedLesson obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.topic)
      ..writeByte(1)
      ..write(obj.content);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedLessonAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
