// Subject games screen listing educational games for rural students.

import 'package:flutter/material.dart';
import 'package:rural_learning_app/l10n/app_localizations.dart';
import 'app_colors.dart';
import 'games/memory_match_game.dart';
import 'games/word_puzzle_game.dart';
import 'games/quiz_game.dart';
import 'games/flashcard_game.dart';
import 'games/topic_matching_game.dart';
import 'games/math_monster_battle_game.dart';

// // Additional games found in lib directory
// import 'game1.dart';
// import 'game2.dart';

class SubjectGamesScreen extends StatelessWidget {
  final String subjectName;

  const SubjectGamesScreen({super.key, required this.subjectName});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    // Example flashcards and pairs for demonstration; ideally, these would be dynamic per subject
    final flashcards = {
      'Atom': 'Basic unit of matter',
      'Molecule': 'Group of atoms bonded together',
      'Cell': 'Basic unit of life',
    };

    final matchingPairs = {
      'Hydrogen': 'H',
      'Oxygen': 'O',
      'Carbon': 'C',
    };

    final games = [
      {
        'title': l10n.memoryMatch,
        'description': l10n.memoryMatchDesc,
        'widget': const MemoryMatchGame(),
      },
      {
        'title': l10n.wordPuzzle,
        'description': l10n.wordPuzzleDesc,
        'widget': const WordPuzzleGame(),
      },
      {
        'title': l10n.quizGame,
        'description': l10n.quizGameDesc,
        'widget': const QuizGame(),
      },
      {
        'title': l10n.flashcardGame,
        'description': l10n.flashcardGameDesc,
        'widget': FlashcardGame(flashcards: flashcards),
      },
      {
        'title': l10n.topicMatching,
        'description': l10n.topicMatchingDesc,
        'widget': TopicMatchingGame(pairs: matchingPairs),
      },
      {
        'title': l10n.mathMonsterBattle,
        'description': l10n.mathMonsterBattleDesc,
        'widget': const MathMonsterBattleGame(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('$subjectName ${l10n.games}', style: const TextStyle(color: Colors.white)),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: games.length,
        itemBuilder: (context, index) {
          final game = games[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: ListTile(
              title: Text(game['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(game['description'] as String),
              trailing: const Icon(Icons.play_arrow),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => game['widget'] as Widget),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
