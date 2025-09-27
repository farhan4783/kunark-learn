import 'package:flutter/material.dart';

class FlashcardGame extends StatefulWidget {
  final Map<String, String> flashcards;

  const FlashcardGame({super.key, required this.flashcards});

  @override
  _FlashcardGameState createState() => _FlashcardGameState();
}

class _FlashcardGameState extends State<FlashcardGame> {
  late List<String> keys;
  int currentIndex = 0;
  bool showAnswer = false;

  @override
  void initState() {
    super.initState();
    keys = widget.flashcards.keys.toList();
  }

  void _nextCard() {
    setState(() {
      showAnswer = false;
      currentIndex = (currentIndex + 1) % keys.length;
    });
  }

  void _toggleAnswer() {
    setState(() {
      showAnswer = !showAnswer;
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = keys[currentIndex];
    final answer = widget.flashcards[question]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Flashcard Game'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showAnswer ? answer : question,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _toggleAnswer,
                child: Text(showAnswer ? 'Show Question' : 'Show Answer'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _nextCard,
                child: const Text('Next'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
