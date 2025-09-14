// lib/offline_quizzes_screen.dart

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'quiz_model.dart';
import 'geography_quiz_screen.dart'; // To navigate to the quiz game

class OfflineQuizzesScreen extends StatelessWidget {
  const OfflineQuizzesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Offline Quizzes'),
      ),
      body: FutureBuilder(
        future: Hive.openBox<SavedQuiz>('saved_quizzes'),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Center(child: Text(snapshot.error.toString()));
            } else {
              final box = Hive.box<SavedQuiz>('saved_quizzes');
              return ValueListenableBuilder(
                valueListenable: box.listenable(),
                builder: (context, Box<SavedQuiz> quizBox, _) {
                  if (quizBox.values.isEmpty) {
                    return const Center(
                      child: Text('You have no saved quizzes yet.'),
                    );
                  }
                  return ListView.builder(
                    itemCount: quizBox.values.length,
                    itemBuilder: (context, index) {
                      final quiz = quizBox.getAt(index)!;
                      return ListTile(
                        leading: const Icon(Icons.quiz_outlined),
                        title: Text(quiz.title),
                        subtitle: Text('${quiz.questions.length} Questions'),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          // When tapped, go directly to the quiz screen with the saved questions
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => GeographyQuizScreen(questions: quiz.questions),
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