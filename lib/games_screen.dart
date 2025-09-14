// lib/games_screen.dart

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'games_model.dart';
import 'memory_match_screen.dart';
import 'quiz_loading_screen.dart';
import 'dart:convert';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'quiz_model.dart';
import 'geography_quiz_screen.dart';

class GamesScreen extends StatelessWidget {
  const GamesScreen({super.key});

  // Dummy data for our list of games
  final List<GameInfo> games = const [
    GameInfo(
      title: 'Math Quiz',
      description: 'Test your arithmetic and problem-solving skills.',
      icon: Icons.calculate,
      color: Colors.orange,
    ),
    GameInfo(
      title: 'Word Puzzle',
      description: 'Find the hidden words and expand your vocabulary.',
      icon: Icons.abc,
      color: Colors.blue,
    ),
    GameInfo(
      title: 'Memory Match',
      description: 'Match the pairs and improve your memory.',
      icon: Icons.memory,
      color: Colors.green,
    ),
    GameInfo(
      title: 'Geography Challenge',
      description: 'How well do you know the world? Find out now!',
      icon: Icons.public,
      color: Colors.red,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Games',
            style: TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return _GameCard(game: game);
        },
      ),
    );
  }
}

// In lib/games_screen.dart, replace the existing _GameCard class

class _GameCard extends StatelessWidget {
  final GameInfo game;

  const _GameCard({required this.game});

  // This is the function that will download the quiz from the AI
  Future<void> _downloadQuiz(BuildContext context) async {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Generating and downloading quiz...'), backgroundColor: AppColors.primary),
    );

    const apiKey = "YOUR_API_KEY_HERE"; // Use your Gemini API Key
    if (apiKey == "YOUR_API_KEY_HERE") return;
    
    final model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);
    const prompt = "Generate a 5-question multiple-choice world geography quiz in JSON format with 'question', 'options', and 'answer' keys.";

    try {
      final response = await model.generateContent([Content.text(prompt)]);
      final text = response.text!.replaceAll('```json', '').replaceAll('```', '').trim();
      final decoded = jsonDecode(HtmlUnescape().convert(text));
      
      final List<QuizQuestion> questions = (decoded as List)
          .map((item) => QuizQuestion.fromJson(item))
          .toList();

      final quiz = SavedQuiz(title: game.title, questions: questions);
      final box = await Hive.openBox<SavedQuiz>('saved_quizzes');
      await box.put(game.title, quiz); // Use game title as the key

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Quiz downloaded successfully!'), backgroundColor: Colors.green),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to download quiz: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isDownloadable = game.title == 'Geography Challenge';

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: game.color.withOpacity(0.15),
                  child: Icon(game.icon, size: 28, color: game.color),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(game.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primary)),
                      const SizedBox(height: 4),
                      Text(game.description, style: const TextStyle(fontSize: 14, color: AppColors.muted)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (isDownloadable)
                  IconButton(
                    icon: const Icon(Icons.download_for_offline_outlined, color: AppColors.primary),
                    onPressed: () => _downloadQuiz(context),
                  ),
                ElevatedButton(
                  onPressed: () async {
                    if (game.title == 'Memory Match') {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MemoryMatchScreen()));
                    } else if (game.title == 'Geography Challenge') {
                      final box = await Hive.openBox<SavedQuiz>('saved_quizzes');
                      final savedQuiz = box.get(game.title); // CORRECTED KEY

                      if (savedQuiz != null && context.mounted) {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => GeographyQuizScreen(questions: savedQuiz.questions))); // CORRECTED SCREEN NAME
                      } else if (context.mounted){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const QuizLoadingScreen()));
                      }
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('${game.title} is coming soon!'), backgroundColor: AppColors.primary));
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  ),
                  child: const Text('Play'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}