// lib/subjects_screen.dart

import 'package:flutter/material.dart';
import 'app_colors.dart'; // Make sure you have this file with your AppColors class
import 'lessons_screen.dart';
import 'subject_model.dart';

class SubjectsScreen extends StatelessWidget {
  const SubjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subjects', style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white), // Makes the back arrow white
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            crossAxisSpacing: 16, // Spacing between cards horizontally
            mainAxisSpacing: 16, // Spacing between cards vertically
            childAspectRatio: 1.2, // Adjust to make cards more rectangular
          ),
          itemCount: subjects.length,
          itemBuilder: (context, index) {
            final subject = subjects[index];
            return SubjectCard(subject: subject);
          },
        ),
      ),
    );
  }
}

class SubjectCard extends StatelessWidget {
  final Subject subject;
  const SubjectCard({Key? key, required this.subject}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the LessonsScreen, passing the subject name
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LessonsScreen(subjectName: subject.name),
          ),
        );
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.accent.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(subject.icon, size: 40, color: AppColors.primary),
            const SizedBox(height: 12),
            Text(
              subject.name,
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}