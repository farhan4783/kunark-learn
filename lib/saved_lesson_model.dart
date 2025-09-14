// lib/saved_lesson_model.dart

import 'package:hive/hive.dart';

part 'saved_lesson_model.g.dart'; // This file will be generated

@HiveType(typeId: 0)
class SavedLesson extends HiveObject {
  @HiveField(0)
  final String topic;

  @HiveField(1)
  final String content;

  SavedLesson({required this.topic, required this.content});
}