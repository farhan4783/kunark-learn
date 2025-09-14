// lib/offline_lessons_screen.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: unused_import
import 'app_colors.dart';
import 'saved_lesson_model.dart';
import 'lesson_viewer_screen.dart'; // We will create this next

class OfflineLessonsScreen extends StatelessWidget {
  const OfflineLessonsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Lessons'),
      ),
      body: FutureBuilder(
        future: Hive.openBox<SavedLesson>('saved_lessons'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              final box = Hive.box<SavedLesson>('saved_lessons');
              return ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, Box<SavedLesson> lessonBox, _) {
                  if (lessonBox.values.isEmpty) {
                    return const Center(
                      child: Text('You have no saved lessons yet.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: lessonBox.values.length,
                    itemBuilder: (context, index) {
                      final lesson = lessonBox.getAt(index)!;
                      return ListTile(
                        title: Text(lesson.topic),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LessonViewerScreen(lesson: lesson),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              );
            }
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}