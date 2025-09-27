import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'generated_lesson_screen.dart';
import 'topics_data.dart';

class SubjectLessonsScreen extends StatelessWidget {
  final String subjectName;

  const SubjectLessonsScreen({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    final topics = subjectsToTopics[subjectName] ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Text('$subjectName Lessons', style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: topics.isEmpty
            ? const Center(child: Text('No topics found for this subject.'))
            : ListView.separated(
                itemCount: topics.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final topic = topics[index];
                  return ListTile(
                    title: Text(topic, style: const TextStyle(fontSize: 18)),
                    trailing: const Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => GeneratedLessonScreen(topic: topic),
                        ),
                      );
                    },
                  );
                },
              ),
      ),
    );
  }
}
