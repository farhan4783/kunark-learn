// lib/lesson_viewer_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'saved_lesson_model.dart';

class LessonViewerScreen extends StatelessWidget {
  final SavedLesson lesson;
  const LessonViewerScreen({super.key, required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(lesson.topic),
      ),
      body: Markdown(
        data: lesson.content,
        padding: const EdgeInsets.all(16.0),
      ),
    );
  }
}