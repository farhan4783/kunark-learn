import 'package:flutter/material.dart';
import 'dart:math';

class MemoryMatchGame extends StatefulWidget {
  const MemoryMatchGame({super.key});

  @override
  _MemoryMatchGameState createState() => _MemoryMatchGameState();
}

class _MemoryMatchGameState extends State<MemoryMatchGame> {
  final int gridSize = 4; // 4x4 grid
  late List<_CardModel> cards;
  _CardModel? firstSelected;
  _CardModel? secondSelected;
  bool allowTap = true;
  int matchesFound = 0;

  @override
  void initState() {
    super.initState();
    _initializeCards();
  }

  void _initializeCards() {
    List<int> numbers = List.generate(gridSize * gridSize ~/ 2, (index) => index);
    numbers = [...numbers, ...numbers]; // duplicate for pairs
    numbers.shuffle(Random());

    cards = numbers.map((num) => _CardModel(id: num)).toList();
  }

  void _onCardTap(int index) {
    if (!allowTap) return;
    if (cards[index].isMatched || cards[index].isRevealed) return;

    setState(() {
      cards[index].isRevealed = true;
      if (firstSelected == null) {
        firstSelected = cards[index];
      } else {
        secondSelected = cards[index];
        allowTap = false;
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            if (firstSelected!.id == secondSelected!.id) {
              firstSelected!.isMatched = true;
              secondSelected!.isMatched = true;
              matchesFound++;
              if (matchesFound == gridSize * gridSize ~/ 2) {
                _showWinDialog();
              }
            } else {
              firstSelected!.isRevealed = false;
              secondSelected!.isRevealed = false;
            }
            firstSelected = null;
            secondSelected = null;
            allowTap = true;
          });
        });
      }
    });
  }

  void _showWinDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Congratulations!'),
        content: const Text('You matched all pairs!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() {
                _initializeCards();
                matchesFound = 0;
              });
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double cardSize = MediaQuery.of(context).size.width / gridSize - 16;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Memory Match Game'),
        backgroundColor: Colors.green[700],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: GridView.builder(
          itemCount: cards.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridSize,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1,
          ),
          itemBuilder: (context, index) {
            final card = cards[index];
            return GestureDetector(
              onTap: () => _onCardTap(index),
              child: Container(
                width: cardSize,
                height: cardSize,
                decoration: BoxDecoration(
                  color: card.isRevealed || card.isMatched ? Colors.green[300] : Colors.green[900],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
                child: Center(
                  child: card.isRevealed || card.isMatched
                      ? Text(
                          '${card.id + 1}',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )
                      : const Icon(Icons.help_outline, color: Colors.white, size: 32),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CardModel {
  final int id;
  bool isRevealed;
  bool isMatched;

  _CardModel({
    required this.id,
    // ignore: unused_element_parameter
    this.isRevealed = false,
    // ignore: unused_element_parameter
    this.isMatched = false,
  });
}
