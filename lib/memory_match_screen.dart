// lib/memory_match_screen.dart

import 'dart:async';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class MemoryMatchScreen extends StatefulWidget {
  const MemoryMatchScreen({super.key});

  @override
  State<MemoryMatchScreen> createState() => _MemoryMatchScreenState();
}

class _MemoryMatchScreenState extends State<MemoryMatchScreen> {
  // --- Game State Variables ---
  List<CardModel> _cards = [];
  CardModel? _firstCard;
  CardModel? _secondCard;
  bool _isChecking = false;
  int _moves = 0;
  int _matches = 0;

  // --- List of Icons for the Cards ---
  final List<IconData> _icons = [
    Icons.star,
    Icons.favorite,
    Icons.lightbulb,
    Icons.school,
    Icons.eco,
    Icons.sunny,
    Icons.rocket_launch,
    Icons.psychology,
  ];

  @override
  void initState() {
    super.initState();
    _setupGame();
  }

  void _setupGame() {
    setState(() {
      _moves = 0;
      _matches = 0;
      _firstCard = null;
      _secondCard = null;

      // Create pairs of cards and shuffle them
      List<IconData> cardIcons = [..._icons, ..._icons];
      cardIcons.shuffle();

      _cards = List.generate(
        cardIcons.length,
        (index) => CardModel(id: index, icon: cardIcons[index]),
      );
    });
  }

  void _onCardTapped(CardModel card) {
    if (_isChecking || card.isFlipped || card.isMatched) return;

    setState(() {
      card.isFlipped = true;
      if (_firstCard == null) {
        _firstCard = card;
      } else {
        _secondCard = card;
        _isChecking = true;
        _moves++;
        _checkForMatch();
      }
    });
  }

  void _checkForMatch() {
    if (_firstCard!.icon == _secondCard!.icon) {
      // It's a match!
      setState(() {
        _firstCard!.isMatched = true;
        _secondCard!.isMatched = true;
        _matches++;
      });
      _resetTurn();
      if (_matches == _icons.length) {
        _showWinDialog();
      }
    } else {
      // Not a match, flip back after a delay
      Future.delayed(const Duration(milliseconds: 800), () {
        setState(() {
          _firstCard!.isFlipped = false;
          _secondCard!.isFlipped = false;
        });
        _resetTurn();
      });
    }
  }

  void _resetTurn() {
    setState(() {
      _firstCard = null;
      _secondCard = null;
      _isChecking = false;
    });
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: Text('You won in $_moves moves!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _setupGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match'),
        backgroundColor: AppColors.primary,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _setupGame,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // --- Scoreboard ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildScoreDisplay('Moves', _moves.toString()),
                _buildScoreDisplay('Matches', '$_matches / ${_icons.length}'),
              ],
            ),
            const SizedBox(height: 20),
            // --- Game Grid ---
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                ),
                itemCount: _cards.length,
                itemBuilder: (context, index) {
                  return MemoryCard(
                    card: _cards[index],
                    onTap: () => _onCardTapped(_cards[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreDisplay(String title, String value) {
    return Column(
      children: [
        Text(title, style: const TextStyle(fontSize: 18, color: AppColors.muted)),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// ===================================================================
// =================== HELPER WIDGETS AND MODELS =====================
// ===================================================================

class MemoryCard extends StatelessWidget {
  final CardModel card;
  final VoidCallback onTap;

  const MemoryCard({super.key, required this.card, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: card.isFlipped ? AppColors.tile : AppColors.primary,
          border: card.isMatched ? Border.all(color: AppColors.accent, width: 3) : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 4,
              offset: const Offset(2, 2),
            ),
          ],
        ),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          transitionBuilder: (child, animation) {
            return FadeTransition(opacity: animation, child: child);
          },
          child: card.isFlipped
              ? Icon(card.icon, size: 40, color: AppColors.primary)
              : const Icon(Icons.question_mark, size: 40, color: Colors.white),
        ),
      ),
    );
  }
}

class CardModel {
  final int id;
  final IconData icon;
  bool isFlipped;
  bool isMatched;

  CardModel({
    required this.id,
    required this.icon,
    this.isFlipped = false,
    this.isMatched = false,
  });
}