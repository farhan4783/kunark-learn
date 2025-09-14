// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedQuizAdapter extends TypeAdapter<SavedQuiz> {
  @override
  final int typeId = 1;

  @override
  SavedQuiz read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedQuiz(
      title: fields[0] as String,
      questions: (fields[1] as List).cast<QuizQuestion>(),
    );
  }

  @override
  void write(BinaryWriter writer, SavedQuiz obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.questions);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedQuizAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class QuizQuestionAdapter extends TypeAdapter<QuizQuestion> {
  @override
  final int typeId = 2;

  @override
  QuizQuestion read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return QuizQuestion(
      question: fields[0] as String,
      options: (fields[1] as List).cast<String>(),
      answer: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, QuizQuestion obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.question)
      ..writeByte(1)
      ..write(obj.options)
      ..writeByte(2)
      ..write(obj.answer);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is QuizQuestionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
