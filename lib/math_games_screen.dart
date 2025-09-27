// Math games screen listing educational games specifically for Maths subject.

import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'games/simple_math_game.dart';

class MathGamesScreen extends StatelessWidget {
  const MathGamesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final games = [
      {
        'title': 'Math Quiz Game',
        'description': 'Test your math skills with fun quizzes!',
        'widget': const MathMonsterBattleGame(),
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Maths Games', style: TextStyle(color: Colors.white)),
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
