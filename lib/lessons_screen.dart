// lib/lessons_screen.dart - UPDATED TO SHOW TOPICS

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'generated_lesson_screen.dart'; // We will create this file next
import 'topics_data.dart'; // Our new topics data

class LessonsScreen extends StatelessWidget {
  final String subjectName;

  const LessonsScreen({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    // Get the list of topics for the selected subject.
    final topics = subjectsToTopics[subjectName] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$subjectName Topics'),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: topics.isEmpty
          ? const Center(child: Text('No topics found for this subject.'))
          : ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: topics.length,
              itemBuilder: (context, index) {
                final topic = topics[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 8),
                  child: ListTile(
                    leading: const Icon(Icons.menu_book, color: AppColors.primary),
                    title: Text(topic, style: const TextStyle(fontWeight: FontWeight.w500)),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                    onTap: () {
                      // Navigate to the screen that will generate the lesson
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GeneratedLessonScreen(topic: topic),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}